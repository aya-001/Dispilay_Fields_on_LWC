import { LightningElement, api,track,wire } from 'lwc';
import getCampaignMemberRecord from '@salesforce/apex/CamaignMemberDetailsController.getCampaignMemberRecord';


export default class campaignMemberDetails extends LightningElement {
    @api recordId; // Task record's ID
    //FirstName;

    @wire(getCampaignMemberRecord, { taskId: '$recordId' })
    campaignMemberData
    /* campaignMemberData(data,error){
        if(data){
            this.FirstName = data.FirstName;
        }else if(error){
            console.error("error", error);
        }
    } */
    /* campaignMemberData; */

    handleClick() {
        console.log("check");
        console.log("record Id: " + this.recordId);
    
        if (this.campaignMemberData && this.campaignMemberData.data) {
            console.log("campaign Member Data: " + JSON.stringify(this.campaignMemberData.data));
        } else {
            console.log("Campaign Member Data is not available yet.");
        }
    }

}

