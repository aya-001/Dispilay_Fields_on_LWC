
global with sharing class AccountMergeController {

     // Define a custom type for the input parameters
    global class MergeInput {
        //master record
        @InvocableVariable(label='Master Record ID')
        global String masterId;
        //duplicate records
        @InvocableVariable(label='Merge Record IDs')
        global List<String> mergeIds;
        //master merge record info
        @InvocableVariable(label='Merge Record Info')
        global Account accMergeRecordInfo;
    }

    // Define a custom type for the output parameter
    global class MergeOutput {
        @InvocableVariable(label='Merge Result')
        global String result;
    }

    // Mark the method as invocable
    @InvocableMethod(label='Merge Accounts')
    global static List<MergeOutput> mergeAccounts(List<MergeInput> inputs) {
        // Initialize the output list
        List<MergeOutput> outputs = new List<MergeOutput>();
        
        // Loop through the input list
        for (MergeInput input : inputs) {
            // Get the master record and the records to be merged
            Account master = [SELECT Id, Name FROM Account WHERE Id = :input.masterId];
            List<Account> duplicates = [SELECT Id, Name FROM Account WHERE Id IN :input.mergeIds];
            
            // Update the master record with the input information
            master.Name = input.accMergeRecordInfo.Name;
            // Add any other fields that you want to update
            
            // Create an output object
            MergeOutput output = new MergeOutput();
            
            try {
                // Perform the merge operation using the Database.merge method
                Database.merge(master, input.mergeIds);
                
                // Set the output result to success
                output.result = 'Success';
                
            } catch (Exception e) {
                // Set the output result to error message
                output.result = 'Error: ' + e.getMessage();
            }
            
            // Add the output object to the output list
            outputs.add(output);
        }
        
        // Return the output list
        return outputs;
    }

}
