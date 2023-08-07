import { LightningElement, track} from 'lwc';

export default class CustomListView extends LightningElement {
    @track customFieldFilter = '';

    handleCustomFieldChange(event) {
        this.customFieldFilter = event.target.value;
    }

    applyFilter() {
        // Dispatch a custom event with the filter criteria to be captured by the parent component
        const filterChangeEvent = new CustomEvent('filterchange', {
            detail: {
                customFieldFilter: this.customFieldFilter
            }
        });
        this.dispatchEvent(filterChangeEvent);
    }


}