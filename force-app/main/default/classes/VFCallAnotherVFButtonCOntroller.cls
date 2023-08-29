//Controller for both of VFCallAnotherVFButton.page and VF2ndCreatePersonAccountButton.page
public with sharing class VFCallAnotherVFButtonCOntroller {
    ApexPages.StandardController returnPage = null;//page to return after submit
    String currentURL = null;
    String url = null;
    public string recordTypeIdvar = '0125i000000BHYXAA4';
    //public string firstName {get; set;}
    //public string lastName {get; set;}
    public Account account {get; set;}


    //constructor
    public VFCallAnotherVFButtonCOntroller(ApexPages.StandardController controller) {
        account = new Account();
        returnPage = controller;
    }

    //call another VF page of 1st VF Page
    public PageReference callAnotherVFPage() {

        //this.currentURL = URL.getSalesforceBaseUrl().toExternalForm() + ApexPages.currentPage().getUrl();
        //System.debug('this.currentURL:' + this.currentURL);
        this.url = ApexPages.currentPage().getUrl();
        System.debug('this.url:' + this.url);


        //get the current account record id
        Id accountId = ApexPages.currentPage().getParameters().get('id');
        // create a new page reference for the other VF page
        PageReference pr = Page.VF2ndCreatePersonAccountButton;
        // pass the account id as a parameter
        pr.getParameters().put('accountId', accountId);
        // return the page reference
        return pr; 
    } 


    //Cancel button of 2nd VF page
    public PageReference doCancel(){
    /* 
        PageReference pageRef = ApexPages.currentPage();
        string currentUrl = pageRef.getUrl();
         */
         //account = new Account();
         //account = null;
        System.debug('doCanel');

        PageReference pageRef = new PageReference(this.url);
         System.debug('pageRef :' + pageRef );
        return pageRef;
   }
 

    //Save button of 2nd VF page
    public PageReference doSave(){
         //get current personAccount record Id
        String id = ApexPages.currentPage().getParameters().get('id');
        Account personAccount = [SELECT Id,ParentsAccount__c FROM Account WHERE Id =:id];
        

        System.debug('Save method');
        //System.debug('account.Name:' + account.Name);
        // String Name = lastName  + firstName;

        //create a new account record with the selected record type ID
         Account newAccount = new Account(RecordTypeId = recordTypeIdvar, Name = account.Name, Industry= account.Industry);
         System.debug('Insert Account ;' + newAccount);
        //insert the new account record
        insert newAccount; 

         //link with the record that was just made through visula Force
        personAccount.ParentsAccount__c = newAccount.Id;
        System.debug('Update PersonAccount ;' + personAccount.ParentsAccount__c );
        update personAccount;


         account = new Account();

        //return to the previous page
        PageReference pageRef = new PageReference(this.url);
        return pageRef;
    }

}