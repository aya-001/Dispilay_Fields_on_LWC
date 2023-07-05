public with sharing class CamaignMemberDetailsController {

    @AuraEnabled(cacheable=true)
    public static CampaignMember getCampaignMemberRecord(Id taskId) {
        Task taskRecord = [SELECT WhoId,Camaign_Member_Record_Id__c FROM Task WHERE Id = :taskId LIMIT 1];
        
        System.debug('Got Taskrecord info' + taskRecord.Camaign_Member_Record_Id__c);

        if (taskRecord.Camaign_Member_Record_Id__c != null) {
            List<CampaignMember> campaignMembers = [SELECT Id, FirstName, LastName, Email FROM CampaignMember WHERE Id = :taskRecord.Camaign_Member_Record_Id__c LIMIT 1];
            if (!campaignMembers.isEmpty()) {
                System.debug('campaign member is not empty' + campaignMembers);
                return campaignMembers[0];
            }
        }
        
        return null;
    }
}
