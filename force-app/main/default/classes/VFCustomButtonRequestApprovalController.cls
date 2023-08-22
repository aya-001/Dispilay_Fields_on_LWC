
public with sharing class VFCustomButtonRequestApprovalController {
    public List<Business_Report__c> reports {get; set;}
    ApexPages.StandardSetController returnPage = null;//page to return after submit
    //public String listViewId {get; set;} // Add this property to store the list view ID


    //contsructer
    public VFCustomButtonRequestApprovalController(ApexPages.StandardSetController controller) {
    reports = (List<Business_Report__c>) controller.getSelected();
   // Get the page where we were earlier
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

    //go back to the oroginal page
    return returnPage.cancel();

    //String returnURL = ApexPages.currentPage().getParameters().get('retURL');
    //String prevUrl = ApexPages.currentPage().getHeaders().get('Referer'); 
    //String url = URL.getSalesforceBaseUrl().toExternalForm() + '/lightning/o/Business_Report__c/list?filterName='/* + this.listViewId */;
    //System.debug('returnURL: '+ returnURL);

    //PageReference pageRef = new PageReference(prevUrl);
    //PageReference pageRef = new PageReference(url);
    //return new PageReference('/'+returnURL);
   
	//return pageRef;

    }

    /* public void getListviewId() {
        this.listViewId = ApexPages.currentPage().getParameters().get('filterName');
    }
     */
  
  public PageReference doCancel(){
    return returnPage.cancel();
  }

}