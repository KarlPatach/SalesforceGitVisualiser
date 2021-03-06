public class PullRequestDataModel {
    public static final String TABLE_NAME = 'GitHub Pull Request';
    
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
        List<Map<String, Object>> pullRequests = new List<Map<String,Object>>();

        List<Map<String, Object>> repos = RepositoryDataModel.fetchRepos();
        

        // For the hack:  don't return more than 98 repos, at 101 Apex will throw an error
        List<Map<String, Object>> filteredRepos = new List<Map<String, Object>>();
        for (Integer i=0; i<repos.size() && i<99; i++){
            filteredRepos.add(repos.get(i));
        }

        for(Map<String, Object> repo : filteredRepos){
            pullRequests.addAll(fetchPullRequests((String)repo.get('Owner_Login'), (String)repo.get('Name')));
        }

        List<Map<String, Object>> prs = DataSource.QueryUtils.process(queryContext, pullRequests);
        DataSource.TableResult tableResult = DataSource.TableResult.get(queryContext, prs);
        return tableResult;
    } 
    
    private static List<Map<String, Object>> fetchPullRequests(String user, String repositoryName){
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        String url = 'callout:GitHubCredentials/repos/' + user + '/' + repositoryName + '/pulls?state=open';
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        
        try {
            // Note: If a 4xx status code occurs when querying the GitHub API, deserializeUntyped()
            // will simply return a Map<Objects> instead of a List<Map<String, Object>>, resulting in
            // a runtime error.
            return getPullRequests(response.getBody());
        } catch (Exception e) {
            // Silent die
            System.debug('Bad response. Response: ' + response.getBody()
                                               + ', Status = ' + response.getStatus()
                                               + ', Status code = ' + response.getStatusCode()
                                               + ', Request: ' + request.getEndpoint());
        } 
        return new List<Map<String,Object>>();
    }
}
