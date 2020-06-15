/**
 * This class corresponds to the custom data provider that the external data source in the org plugs in to.
 */
global class GitHubProvider extends DataSource.Provider {
 
    override global List<DataSource.Capability> getCapabilities() {
        List<DataSource.Capability> capabilities = new List<DataSource.Capability>();
        capabilities.add(DataSource.Capability.ROW_QUERY);
        //capabilities.add(DataSource.Capability.SEARCH);
        return capabilities;
    }
     
    override global List<DataSource.AuthenticationCapability> getAuthenticationCapabilities() {
        List<DataSource.AuthenticationCapability> capabilities = new List<DataSource.AuthenticationCapability>();
        capabilities.add(DataSource.AuthenticationCapability.ANONYMOUS);
        capabilities.add(DataSource.AuthenticationCapability.BASIC);
        capabilities.add(DataSource.AuthenticationCapability.OAUTH);
        return capabilities;
    }
     
    override global DataSource.Connection getConnection(DataSource.ConnectionParams connectionsParams) {
        return new SFDC2GitHubConnection();
    }
     
}