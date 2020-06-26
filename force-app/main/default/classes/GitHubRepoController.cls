public with sharing class GitHubRepoController {
    @AuraEnabled(cacheable=true)
    public static List<GitHub_Repository__x> fetchGitHubRepos() {
        
        List<GitHub_Repository__x> repoList = [
            SELECT Id, 
            DisplayUrl,
            Name__c,
            Description__c,
            RepoCreatedDate__c,
            RepoUpdatedDate__c,
            LastPushedDate__c,
            Language__c,
            OpenIssuesCount__c,
            Private__c,
            TotalForks__c,
            Stars__c,
            Size__c            
               from GitHub_Repository__x 
               ORDER BY LastPushedDate__c DESC
                LIMIT 1000];
        
        return repoList;
    }
}
