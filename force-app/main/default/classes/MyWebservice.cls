global with sharing class MyWebservice {

    WebService static String customSubmitApproval(List<Business_Report__c> selectedRecordIdList) {

        try{

            //Create a list of Approval.ProcessSubmitRequest objects
            List<Approval.ProcessSubmitRequest> reqs = new List<Approval.ProcessSubmitRequest>();
            //Loop through the records you want to submit for approval
            for(Business_Report__c br : selectedRecordIdList){
                //Create an instance of the Approval.ProcessSubmitRequest class for each record
                Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                //Set the ID of the record you want to submit for approval
                req.setObjectId(br.Id);
                //Add the request to the list
                reqs.add(req);
            }
            //Call the Approval.process method and pass the list as a parameter
            Approval.ProcessResult[] results = Approval.process(reqs);
            //Check the status of each result

            Integer x = 0;
            Integer y = 0;
            for(Approval.ProcessResult result : results){
                if(result.isSuccess()){
                    //The submission was successful
                    x++;
                    System.debug('Record submitted for approval successfully.');
                }else{
                    //The submission failed
                    y++;
                    System.debug('Record failed to submit for approval.');
                }
            }

            return '成功' + x +'件, 失敗'+ y +'件';

       }catch(Exception e){
            return 'Something is wrong...';

       }
    }
}