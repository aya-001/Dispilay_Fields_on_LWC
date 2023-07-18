public with sharing class CamaignMemberDetailsController {

    @AuraEnabled(cacheable=true)
    public static CampaignMember getCampaignMemberRecord(Id taskId) {
        //get task Id and Campaign member Id
        Task taskRecord = [SELECT WhoId,Campaign_Member_RecordId__c FROM Task WHERE Id = :taskId LIMIT 1];
        
        System.debug('Got Taskrecord info' + taskRecord.Campaign_Member_RecordId__c);

        //get Campaign Member Fields Value
        if (taskRecord.Campaign_Member_RecordId__c != null) {
            List<CampaignMember> campaignMembers = 
                [SELECT Id, Customer_Name__c, Lead_Start_Date__c, Lead_End_Date__c, DM_Dispatch_date__c, FirstName, LastName, Priority_Level__c, Additional_Information_1__c, Additional_Information_2__c,
                        Additional_Information_3__c, Large_Code__c, Campaign_Type__c, Trigger_Type__c,PA_Code__c, Campaign_Guide__c, SCID__c, Product_Code__c, Policy_Number__c, 
                        PostalCode, Phone, MobilePhone, Ready_To_Publish__c, UMC_Lookup_Issue_Present__c, Logged_Is_PA_User__c, Servicing_PA__c
                WHERE Id = :taskRecord.Campaign_Member_RecordId__c 
                LIMIT 1];

            if (!campaignMembers.isEmpty()) {
                System.debug('campaign member is not empty' + campaignMembers);
                return campaignMembers[0];
            }
        }
        
        return null;
    }
}
