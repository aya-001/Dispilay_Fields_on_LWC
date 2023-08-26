public with sharing class VFCreateersonAccountButtonController {
    ApexPages.StandardController returnPage = null;//page to return after submit
   /*  public String recordTypeId {get; set;} //variable to store the selected record type ID 
    public List<SelectOption> recordTypes {get; set;} //variable to store the list of record types
 */
     //public String firstName {get; set;} //variable to store the first name 
     //public String lastName {get; set;} //variable to store the last name
    public string recordTypeIdvar = '0125i000000BHYXAA4';
    public string firstName {get; set;}
    public string lastName {get; set;}

    

    //constructor
    public VFCreateersonAccountButtonController(ApexPages.StandardController controller) {
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



    public PageReference doCancel(){
        return returnPage.cancel();
    }
}