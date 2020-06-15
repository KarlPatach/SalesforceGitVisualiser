/**
* This is the class corresponding to the actual GitHub API calls, the most important of which is query().
*/
global class SFDC2GitHubConnection extends DataSource.Connection {
  override global List<DataSource.Table> sync() {
      List<DataSource.Table> tables = new List<DataSource.Table>();
      tables.add(RepositoryDataModel.buildTable());
      tables.add(PullRequestDataModel.buildTable());
      tables.add(IssueDataModel.buildTable());
      return tables;
  }
  
  override global DataSource.TableResult query(DataSource.QueryContext queryContext) {
      if (queryContext.tableSelection.tableSelected == RepositoryDataModel.TABLE_NAME) {
          return RepositoryDataModel.handleQuery(queryContext);
      }
      if (queryContext.tableSelection.tableSelected == PullRequestDataModel.TABLE_NAME) {
        return PullRequestDataModel.handleQuery(queryContext);
      }
      if (queryContext.tableSelection.tableSelected == IssueDataModel.TABLE_NAME) {
        return IssueDataModel.handleQuery(queryContext);
      }
      throw new IllegalArgumentException('Selected table is not supported: ' + queryContext.tableSelection.tableSelected);
  }
  
  override global List<DataSource.TableResult> search(DataSource.SearchContext searchContext) {
      return DataSource.SearchUtils.searchByName(searchContext, this);
  }
}