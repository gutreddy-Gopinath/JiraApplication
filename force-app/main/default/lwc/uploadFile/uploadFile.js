import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FileUploadComponent extends LightningElement {
    @api recordId;
    
    handleRecordIdChange(event) {
        this.recordId = event.target.value;
    }

    @wire(getRecord, { recordId: '$recordId', fields: ['Account.Name'] })
    wiredRecord({ error, data }) {
        if (data) {
            // Handle fetched record data if needed
            console.log('Fetched Record Data:', data);
        } else if (error) {
            // Handle error if record fetch fails
            console.error('Error fetching record:', error);
        }
    }

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        
        // Perform additional logic if needed with the uploaded files
        console.log('Uploaded Files:', uploadedFiles);

        // Display a success message
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'File uploaded successfully!',
                variant: 'success',
            })
        );
    }
}