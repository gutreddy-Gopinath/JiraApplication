import { LightningElement, api, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import PROPERTY_OBJECT from '@salesforce/schema/Property__c';

export default class PropertyImagesUploadLWC extends LightningElement {
    @api recordId; // Record Id of the Property__c record
    @track propertyName = '';
    acceptedFormats = ['.png', '.jpg', '.jpeg'];

    handleNameChange(event) {
        this.propertyName = event.target.value;
    }

    async handleUploadFinished(event) {
        try {
            // Ensure propertyName is provided
            if (!this.propertyName) {
                throw new Error('Please provide a Property Name before uploading images.');
            }

            // Create Property__c record
            const propertyRecord = await createRecord({
                apiName: PROPERTY_OBJECT.objectApiName,
                fields: {
                    Name: this.propertyName,
                },
            });

            this.showSuccessMessage('Property record created successfully');
            console.log('Property Record Id:', propertyRecord.id);

            // Perform additional actions if needed, such as associating the uploaded files with the created record
            // You can use propertyRecord.id to get the newly created record Id

            // Example: Associate the uploaded files with the created Property__c record
            const uploadedFiles = event.detail.files;
            const filesToAssociate = uploadedFiles.map(file => ({
                recordId: propertyRecord.id,
                contentDocumentId: file.documentId,
            }));

            // Perform your logic to associate files with the record
            // ...

        } catch (error) {
            console.error('Error creating record', error);
            this.showErrorMessage(error.message || 'An error occurred while creating the property record. Please try again.');
        }
    }

    showErrorMessage(message) {
        this.dispatchEvent(new ShowToastEvent({ title: 'Error', message, variant: 'error' }));
    }

    showSuccessMessage(message) {
        this.dispatchEvent(new ShowToastEvent({ title: 'Success', message, variant: 'success' }));
    }
}