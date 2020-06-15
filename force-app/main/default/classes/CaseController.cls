public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> fetchCases() {
        
        List<Case> closedCaseList = [
            SELECT Id, 
            Subject,
            Description,
            CreatedDate,            
            Status,
            Origin,
            Type,
            Priority,
            Pull_Request__c
               from Case 
               WHERE ClosedDate = null
               ORDER BY Priority, CreatedDate 
                LIMIT 10];
        
        return closedCaseList;
    }
}
