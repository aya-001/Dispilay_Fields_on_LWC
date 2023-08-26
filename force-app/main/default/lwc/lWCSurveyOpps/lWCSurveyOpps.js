import { LightningElement } from 'lwc';

export default class LWCSurveyOpps extends LightningElement {
   
connectedCallback() {    
// Get all the tab links
    let tablinks = this.template.querySelectorAll('.slds-tabs_default__link');

    // Loop through the tab links and add click event listeners
    tablinks.forEach(tablink => {
    tablink.addEventListener('click', event => {
        console.log("clicked by mouse");
        // Prevent default behavior of the link
        event.preventDefault();

        // Get the id of the tab content to show
        let tabId = event.target.getAttribute('aria-controls');

        // Get the tab content element by id
        let tabContent = this.template.querySelector('#' + tabId);

        // Hide all the other tab contents
        this.template.querySelectorAll('.slds-tabs_default__content').forEach(tab => {
        tab.classList.add('slds-hide');
        tab.classList.remove('slds-show');
        });

        // Show the selected tab content
        tabContent.classList.add('slds-show');
        tabContent.classList.remove('slds-hide');
    });
    });

}


    handlclick(){
        console.log("handlclick");
    }
}