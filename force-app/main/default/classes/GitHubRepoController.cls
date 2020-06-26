public with sharing class GitHubRepoController {
    @AuraEnabled(cacheable=true)
    public static List<GitHub_Repository__x> fetchGitHubRepos() {
        
        List<GitHub_Repository__x> repoList = [
            SELECT Id, 
            DisplayUrl,
            Name__c,
            Description__c,
            Repository_Created_Date__c,
            Repository_Updated_Date__c,
            Last_Pushed_Date__c,
            Language__c,
            Open_Issues_Count__c,
            Private__c,
            TotalForks__c,
            Stars__c,
            Size__c            
               from GitHub_Repository__x 
               ORDER BY Last_Pushed_Date__c DESC
                LIMIT 1000];
        
        return repoList;
    }
}
