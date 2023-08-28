public with sharing class VFCreateersonAccountButtonController {
    
    ApexPages.StandardController returnPage = null;//page to return after submit
   
    public string recordTypeIdvar = '0125i000000BHYXAA4';
    public string firstName {get; set;}
    public string lastName {get; set;}
    public Account account {get; set;}

    

    //constructor
    public VFCreateersonAccountButtonController(ApexPages.StandardController controller) {
        //initialize the account variable
        account = new Account();
        returnPage = controller;
    }


    public PageReference doSave(){
        System.debug('Save method');
        //System.debug(lastName + firstName:' + lastName  + firstName);
        System.debug('lastName + firstName:' + lastName  + firstName);


        String Name = lastName  + firstName;
        //create a new account record with the selected record type ID
         Account newAccount = new Account(RecordTypeId = recordTypeIdvar, Name = Name);
         System.debug('Insert Account ;' + newAccount);
        //insert the new account record
        insert newAccount; 
        //return to the previous page
        return returnPage.cancel();
    }


 /*
//-------------------------------------------------------------------------
public with sharing class VFCreateersonAccountButtonController {
    ApexPages.StandardController returnPage = null;//page to return after submit
   
    public string recordTypeIdvar = '0129D000001joDQQAY';
    public string firstName {get; set;}
    public string lastName {get; set;}
    public Account account {get; set;}


    //constructor
    public VFCreateersonAccountButtonController(ApexPages.StandardController controller) {
        account = new Account();
        returnPage = controller;
    }


   public PageReference doSave(){
        //get current personAccount record Id
        String id = ApexPages.currentPage().getParameters().get('id');
        Account personAccount = [SELECT Id,Name_of_workspace__pc FROM Account WHERE Id =:id];
        

        System.debug('Save method');
        System.debug('lastName + firstName:' + lastName  + firstName);
        System.debug('account.Name:' + account.Name);
        System.debug('account.Corporate_Name_Input_Kana__c:' + account.Corporate_Name_Input_Kana__c);


        //create a new account record with the selected record type ID
          Account newAccount = new Account(RecordTypeId = recordTypeIdvar, Name = account.Name, Corporate_Name_Input_Kana__c = account.Corporate_Name_Input_Kana__c, Industry = account.Industry, Account_Samakata_Kanji__c = account.Account_Samakata_Kanji__c, Account_Samakata_Kana__c = account.Account_Samakata_Kana__c,  Account_AddressMaster_PostalCode__c = account.Account_AddressMaster_PostalCode__c);
         System.debug('Insert Account ;' + newAccount);
        //insert the new account record
        insert newAccount; 

        //Account workAccount = [SELECCT Id from Account WHERE ];

        //link with the record that was just made through visula Force
        personAccount.Name_of_workspace__pc = newAccount.Id;
        System.debug('Update PersinAccount ;' + personAccount.Name_of_workspace__pc );
        update personAccount;

        //return to the previous page
        return returnPage.cancel();
    }



    public PageReference doCancel(){
        return returnPage.cancel();
    }
}

 */