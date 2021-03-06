public class RepositoryDataModel {
    public static final String TABLE_NAME = 'GitHub Repository';

    public static DataSource.Table buildTable(){
        List<DataSource.Column> columns = new List<DataSource.Column>();
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.text('Name', 128));
        columns.add(DataSource.Column.text('Description', 1024));

        columns.add(DataSource.Column.number('Stars', 16, 0));

        columns.add(DataSource.Column.boolean('Private'));
        columns.add(DataSource.Column.boolean('Fork'));

        columns.add(DataSource.Column.url('DisplayUrl'));

        DataSource.Column repositoryUrlColumn = DataSource.Column.url('Repository_URL');
        repositoryUrlColumn.label = 'Repository URL';
        columns.add(repositoryUrlColumn);

        DataSource.Column languaguesUrlColumn = DataSource.Column.url('Languages_URL');
        languaguesUrlColumn.label = 'Languages URL';
        columns.add(languaguesUrlColumn);

        columns.add(DataSource.Column.text('Language'));
        
        columns.add(DataSource.Column.text('Repository_Created_Date', 'Repository Created Date', 255));
        columns.add(DataSource.Column.text('Repository_Updated_Date', 'Repository Updated Date', 255));
        columns.add(DataSource.Column.text('Last_Pushed_Date', 'Last Pushed Date', 255));

        columns.add(DataSource.Column.boolean('Archived'));
        columns.add(DataSource.Column.boolean('Disabled'));

        DataSource.Column openIssuesCount = DataSource.Column.number('Open_Issues_Count', 16, 0);
        openIssuesCount.label = 'Open Issues Count';
        columns.add(openIssuesCount);

        columns.add(DataSource.Column.text('License'));

        columns.add(DataSource.Column.number('Size', 16, 0));

        DataSource.Column totalForks = DataSource.Column.number('Total_Forks', 16, 0);
        totalForks.label = 'Total Forks';
        columns.add(totalForks);
        
        columns.add(DataSource.Column.number('Watchers', 16, 0));

        columns.add(DataSource.Column.text('Owner_Login', 'Owner Login', 255));
        
        Datasource.Table repositoryTable = DataSource.Table.get(TABLE_NAME, 'Name', columns);
        repositoryTable.labelPlural = 'GitHub Repositories';
        repositoryTable.labelSingular = 'GitHub Repository';
        return repositoryTable;
    }

    private static List<Map<String, Object>> getRepositories(String content){
        if (content == null || ''.equals(content)) {
            return new List<Map<String,Object>>();
        }
        List<Map<String, Object>> repositories = new List<Map<String, Object>>();
        for (Object item : (List<Object>)JSON.deserializeUntyped(content)) {
            repositories.add(buildRepositoryFromJson(item));
        }
        return repositories;
    }

    private static Map<String, Object> buildRepositoryFromJson(Object item){
        Map<String, Object> repo = (Map<String, Object>)item;
        repo.put('ExternalId', repo.get('id'));
        repo.put('Name', repo.get('name'));
        repo.put('Description', repo.get('description'));
        repo.put('Stars', repo.get('stargazers_count'));

        repo.put('Private', repo.get('private'));
        repo.put('Fork', repo.get('fork'));

        repo.put('DisplayUrl', repo.get('html_url'));
        repo.put('Repository_URL', repo.get('html_url'));
        repo.put('Languages_URL', repo.get('languages_url'));

        repo.put('Language', repo.get('language'));

        repo.put('Repository_Created_Date', DataUtils.transformDate((String)repo.get('created_at')));
        repo.put('Repository_Updated_Date', DataUtils.transformDate((String)repo.get('updated_at')));
        repo.put('Last_Pushed_Date', DataUtils.transformDate((String)repo.get('pushed_at')));

        repo.put('Archived', repo.get('archived'));
        repo.put('Disabled', repo.get('disabled'));

        repo.put('Open_Issues_Count', repo.get('open_issues_count'));

        repo.put('License', repo.get('license'));

        repo.put('Size', repo.get('size'));
        repo.put('Total_Forks', repo.get('forks_count'));
        repo.put('Watchers', repo.get('watchers_count'));

        Map<String, Object> owner = (Map<String, Object>)repo.get('owner');
        repo.put('Owner_Login', owner.get('login'));

        return repo;
    }

    public static List<Map<String, Object>> fetchRepos(){
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        String url = 'callout:GitHubCredentials/user/repos?per_page=1000';
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);

        try {
            // Note: If a 4xx status code occurs when querying the GitHub API, deserializeUntyped()
            // will simply return a Map<Objects> instead of a List<Map<String, Object>>, resulting in
            // a runtime error.
            return getRepositories(response.getBody());
        } catch (Exception e) {
            throw new IllegalArgumentException('Bad response. Response: ' + response.getBody()
            + ', Status = ' + response.getStatus()
            + ', Status code = ' + response.getStatusCode()
            + ', Request: ' + request.getEndpoint(), e);
        }  
    }

    public static DataSource.TableResult handleQuery(DataSource.QueryContext queryContext) {
        List<Map<String, Object>> repos = DataSource.QueryUtils.process(queryContext, fetchRepos());
        DataSource.TableResult tableResult = DataSource.TableResult.get(queryContext, repos);
        return tableResult;     
    }
}
