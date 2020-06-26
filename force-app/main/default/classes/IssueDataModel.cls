public with sharing class IssueDataModel {
    public static final String TABLE_NAME = 'GitHub Issues';
    
    public static DataSource.Table buildTable(){
        List<DataSource.Column> columns = new List<DataSource.Column>();
        // mandatory fields
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.url('DisplayUrl'));


        columns.add(DataSource.Column.url('Repository_URL'));
        columns.add(DataSource.Column.text('RepositoryId'));
        columns.add(DataSource.Column.url('Issue_URL'));
        
        
        columns.add(DataSource.Column.number('Number', 16, 0));
        
        columns.add(DataSource.Column.text('State'));
        columns.add(DataSource.Column.text('Title'));
        columns.add(DataSource.Column.text('Body'));
        
        columns.add(DataSource.Column.text('Created_Date'));
        columns.add(DataSource.Column.text('Updated_Date'));
        columns.add(DataSource.Column.text('Closed_Date'));

        columns.add(DataSource.Column.text('Owner'));
        columns.add(DataSource.Column.text('OwnerId'));

        columns.add(DataSource.Column.text('Assignee'));
        columns.add(DataSource.Column.text('AssigneeId'));
        columns.add(DataSource.Column.text('User'));
      
        columns.add(DataSource.Column.url('Pull_Request'));
        
        return DataSource.Table.get(TABLE_NAME, 'Number', columns);
    } 
    
    //Test Only
    public static List<Map<String, Object>> getIssues(String content){
        if (content == null || ''.equals(content)) {
            return new List<Map<String,Object>>();
        }
        List<Map<String, Object>> issues = new List<Map<String, Object>>();
        for (Object item : (List<Object>)JSON.deserializeUntyped(content)) {
            issues.add(buildIssuesFromJson(item));
        }
        return issues;
    }
    
    private static Map<String, Object> buildIssuesFromJson(Object item){
        Map<String, Object> issue = (Map<String, Object>)item;
        issue.put('ExternalId', issue.get('id'));

        issue.put('DisplayUrl', issue.get('url'));

        issue.put('Repository_URL', ApiUtils.apiUrlToGitHub((String)issue.get('repository_url')));
        issue.put('Issue_URL', ApiUtils.apiUrlToGitHub((String)issue.get('url')));

        issue.put('Number', issue.get('number'));

        issue.put('State', issue.get('state'));
        issue.put('Title', issue.get('title'));
        issue.put('Body', issue.get('body'));


        issue.put('Created_Date', DataUtils.transformDate((String)issue.get('created_at')));
        issue.put('Updated_Date',  DataUtils.transformDate((String)issue.get('updated_at')));
        issue.put('Closed_Date',  DataUtils.transformDate((String)issue.get('closed_at')));


        Map<String,Object> user=(Map<String,Object>)issue.get('user');
        issue.put('Owner', user.get('login'));
        issue.put('OwnerId', user.get('id'));
		
        Map<String,Object> assignee=(Map<String,Object>)issue.get('assignee');
        if(assignee!=null){
            issue.put('Assignee', assignee.get('login'));
            issue.put('AssigneeId', assignee.get('id'));
            issue.put('User', assignee.get('login'));
        }

        Map<String,Object> repository=(Map<String,Object>)issue.get('repository');
        if(assignee!=null){
            issue.put('RepositoryId', repository.get('id'));
        }

        Map<String,Object> pullRequest=(Map<String,Object>)issue.get('pull_request');
        if(pullRequest!=null && pullRequest.containsKey('url')){
          issue.put('Pull_Request', pullRequest.get('url'));
        }
        
        return issue;
    } 
    
    public static DataSource.TableResult handleQuery(DataSource.QueryContext queryContext){
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();

        String url = 'callout:GitHubCredentials/issues?filter=all&state=all';
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        
        try {
            // Note: If a 4xx status code occurs when querying the GitHub API, deserializeUntyped()
            // will simply return a Map<Objects> instead of a List<Map<String, Object>>, resulting in
            // a runtime error.
            List<Map<String, Object>> pullRequests = getIssues(response.getBody());
            List<Map<String, Object>> prs = DataSource.QueryUtils.process(queryContext, pullRequests);
            DataSource.TableResult tableResult = DataSource.TableResult.get(queryContext, prs);
            
            return tableResult;
            
        } catch (Exception e) {
            throw new IllegalArgumentException('Bad response. Response: ' + response.getBody()
                                               + ', Status = ' + response.getStatus()
                                               + ', Status code = ' + response.getStatusCode()
                                               + ', Request: ' + request.getEndpoint(), e);
        }       
    } 
}