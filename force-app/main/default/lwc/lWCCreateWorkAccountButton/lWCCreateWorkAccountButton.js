import { LightningElement, api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class LWCCreateWorkAccountButton  extends NavigationMixin(LightningElement){
    @api recordId;//get record Id of currentPage


    handleClick(event) {
        // do something when the button is clicked
        // for example, navigate to the VF page
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/apex/VFCreateersonAccountButton?recordId=' + this.recordId // pass the record id as a parameter
            }
        });
        // listen for the message from the VF page
        //window.addEventListener('message', this.handleMessage.bind(this));
    }

}