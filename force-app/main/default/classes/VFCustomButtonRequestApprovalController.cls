
public with sharing class VFCustomButtonRequestApprovalController {
    public List<Business_Report__c> reports {get; set;}
    ApexPages.StandardSetController returnPage = null;

    //contsructer
    public VFCustomButtonRequestApprovalController(ApexPages.StandardSetController controller) {
    reports = (List<Business_Report__c>) controller.getSelected();

    returnPage = controller;
  }

  public PageReference submitForApproval() {
    List<Approval.ProcessSubmitRequest> reqs = new List<Approval.ProcessSubmitRequest>();
    for (Business_Report__c report : reports) {
       if (!report.Submitted_for_approval__c == true) { 
        report.Submitted_for_approval__c = true;
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitted by ' + UserInfo.getName());
        req.setObjectId(report.Id);
        reqs.add(req);
      } 
    }
    Update reports;

    List<Approval.ProcessResult> results = Approval.process(reqs);
    // Check results
    System.debug('Results:' + results);
    
    return null; // Stay on the same page
  }

  public PageReference doCancel(){
    return returnPage.cancel();
  }


}