public class PullRequestDataModel {
    public static final String TABLE_NAME = 'GitHub Pull Request';
    private static final Pattern pullRequestUrlPattern = Pattern.compile('https:\\/\\/api.github.com\\/repos\\/(\\S+)\\/(\\S+)\\/pulls\\/(\\d+)');
    
    public static DataSource.Table buildTable(){
        List<DataSource.Column> columns = new List<DataSource.Column>();
        // mandatory fields
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.url('DisplayUrl'));

        DataSource.Column pullRequestUrl = DataSource.Column.url('Pull_Request_URL');
        pullRequestUrl.label = 'Pull Request Url';
        columns.add(pullRequestUrl);
        
        columns.add(DataSource.Column.boolean('Draft'));
        
        columns.add(DataSource.Column.number('Number', 16, 0));
        
        columns.add(DataSource.Column.text('State'));
        columns.add(DataSource.Column.text('Title'));
        columns.add(DataSource.Column.text('Body'));
        
        columns.add(DataSource.Column.text('Owner'));
        columns.add(DataSource.Column.text('OwnerId'));
        
        columns.add(DataSource.Column.text('Pull_Request_Created_Date', 'Pull Request Created Date', 255));
        columns.add(DataSource.Column.text('Pull_Request_Updated_Date', 'Pull Request Updated Date', 255));
        columns.add(DataSource.Column.text('Closed_Date', 'Closed Date', 255));
        columns.add(DataSource.Column.text('Merged_Date', 'Merged Date', 255));
        
        columns.add(DataSource.Column.boolean('Merged'));

        //parent id
        columns.add(DataSource.Column.text('Repository_Name', 'Repository Name', 255));
        
        DataSource.Table pullRequestTable = DataSource.Table.get(TABLE_NAME, 'Number', columns);
        pullRequestTable.labelSingular = 'GitHub Pull Request';
        pullRequestTable.labelPlural = 'GitHub Pull Requests';
        return pullRequestTable;
    } 
    
    //Test Only
    public static List<Map<String, Object>> getPullRequests(String content){
        if (content == null || ''.equals(content)) {
            return new List<Map<String,Object>>();
        }
        List<Map<String, Object>> pullRequests = new List<Map<String, Object>>();
        for (Object item : (List<Object>)JSON.deserializeUntyped(content)) {
            pullRequests.add(buildPRFromJson(item));
        }
        return pullRequests;
    }
    
    private static Map<String, Object> buildPRFromJson(Object item){
        Map<String, Object> pullRequest = (Map<String, Object>)item;
        pullRequest.put('ExternalId', pullRequest.get('id'));

        pullRequest.put('DisplayUrl', pullRequest.get('url'));

        pullRequest.put('Pull_Request_URL', ApiUtils.apiUrlToGitHub((String)pullRequest.get('url')));

        pullRequest.put('Draft', pullRequest.get('draft'));

        pullRequest.put('Number', pullRequest.get('number'));

        pullRequest.put('State', pullRequest.get('state'));
        pullRequest.put('Title', pullRequest.get('title'));
        pullRequest.put('Body', pullRequest.get('body'));


        pullRequest.put('Pull_Request_Created_Date', DataUtils.transformDate((String)pullRequest.get('created_at')));
        pullRequest.put('Pull_Request_Updated_Date', DataUtils.transformDate((String)pullRequest.get('updated_at')));
        pullRequest.put('Closed_Date', DataUtils.transformDate((String)pullRequest.get('closed_at')));
        pullRequest.put('Merged_Date', DataUtils.transformDate((String)pullRequest.get('merged_at')));


        pullRequest.put('Merged', pullRequest.get('merged'));

        Map<String,Object> user=(Map<String,Object>)pullRequest.get('user');
        pullRequest.put('Owner', user.get('login'));
        pullRequest.put('OwnerId', user.get('id'));


        Map<String,Object> base=(Map<String,Object>)pullRequest.get('base');
        Map<String,Object> repo=(Map<String,Object>)base.get('repo');
        pullRequest.put('Repository_Name', repo.get('name'));
        
        return pullRequest;
    } 

    public static DataSource.TableResult handleQuery(DataSource.QueryContext queryContext){
        List<Map<String, Object>> pullRequests = DataSource.QueryUtils.process(queryContext, fetchPullRequests());
        DataSource.TableResult tableResult = DataSource.TableResult.get(queryContext, pullRequests);
        return tableResult;
    } 
    
    public static List<Map<String, Object>> fetchPullRequests(){
        List<Map<String, Object>> pullRequests = new List<Map<String,Object>>();

        List<Map<String, Object>> issues = IssueDataModel.fetchIssues();
        
        for (Map<String,Object> issue : issues){
            Map<String,Object> pullRequest=(Map<String,Object>)issue.get('pull_request');
            if(pullRequest!=null && pullRequest.containsKey('url')){
                pullRequests.add(
                    fetchPullRequest(
                        getPullRequestUrlFromRawUrl((String) pullRequest.get('url')
                        )
                    )
                );
            }
        }

        return pullRequests;
    }

    private static Map<String, Object> fetchPullRequest(String pullRequestUrl){
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(pullRequestUrl);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        
        try {
            // Note: If a 4xx status code occurs when querying the GitHub API, deserializeUntyped()
            // will simply return a Map<Objects> instead of a List<Map<String, Object>>, resulting in
            // a runtime error.
            return buildPRFromJson((Map<String, Object>)JSON.deserializeUntyped(response.getBody()));
        } catch (Exception e) {
            // Silent die
            System.debug(e.getMessage());
            System.debug('Bad response. Response: ' + response.getBody()
                                               + ', Status = ' + response.getStatus()
                                               + ', Status code = ' + response.getStatusCode()
                                               + ', Request: ' + request.getEndpoint());
        } 
        return new Map<String,Object>();
    }

    private static String getPullRequestUrlFromRawUrl(String rawUrl){
        Matcher patternMatcher = pullRequestUrlPattern.matcher( rawUrl );
        if( patternMatcher.matches() ){
            String url = 'callout:GitHubCredentials/repos/' + patternMatcher.group(1) + '/' + patternMatcher.group(2) + '/pulls/' + patternMatcher.group(3);
            return url;
        }
        throw new IllegalArgumentException('Badly formatted pull request URL. Response: ' + rawUrl);
    }
}
