

public with sharing class VFCustomButtonRequestApprovalController {
    public List<Business_Report__c> reports {get; set;}
    ApexPages.StandardSetController returnPage = null;//page to return after submit
    
    //contsructer
    public VFCustomButtonRequestApprovalController(ApexPages.StandardSetController controller) {
    //get selected records from list view age
    reports = controller.getSelected(); // List<Business_Report__c>
   // Get the page where we were earlier
    returnPage = controller;
    
  }

  public PageReference submitForApproval() {
    //instance of Approval.ProcessSubmitRequest class
    List<Approval.ProcessSubmitRequest> reqs = new List<Approval.ProcessSubmitRequest>();
    //loop by Business_Report__c selected records
    for (Business_Report__c report : reports) {
       if (!report.Submitted_for_approval__c == true) { 
        report.Submitted_for_approval__c = true;
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitted by ' + UserInfo.getName());
        req.setObjectId(report.Id);
        //req.setNextApproverIds(null);
        reqs.add(req);
      } 
    }
    Update reports;

    System.debug('reqs:' + reqs);
    

     //the approval results
    List<Approval.ProcessResult> results = Approval.process(reqs);

    // Check results
    System.debug('Results:' + results);

    //go back to the oroginal page
    return returnPage.cancel();
    }
  
  //go back to ListView age
  public PageReference doCancel(){
    return returnPage.cancel();
  }

}