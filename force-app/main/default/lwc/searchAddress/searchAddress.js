import { LightningElement, api } from 'lwc';
import beginSearchAddress from '@salesforce/apexContinuation/AccountAdressService.beginSearchAddress';
import { updateRecord } from 'lightning/uiRecordApi';
import ACCOUNT_BILLING_CITY  from '@salesforce/schema/Account.BillingCity';
import ACCOUNT_BILLING_COUNTRY  from '@salesforce/schema/Account.BillingCountry';
import ACCOUNT_BILLING_STATE  from '@salesforce/schema/Account.BillingState';
import ACCOUNT_BILLING_STREET  from '@salesforce/schema/Account.BillingStreet';
import ACCOUNT_BILLING_ZIPCODE  from '@salesforce/schema/Account.BillingPostalCode';
import ACCOUNT_ID  from '@salesforce/schema/Account.Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SearchAddress extends LightningElement {

    @api recordId

    inputZipCode = '';
    address = undefined;

    updateZipCode(e){
        this.inputZipCode = e.target.value;
    }

    async callAddressWS(){
        try {

            this.address = await beginSearchAddress({zipCode:this.inputZipCode});

            console.log(this.address);
            
        } catch (error) {
            console.error(error);
        }
    }

    async updateAddress(){
        try {
            
            const fields = {
                [ACCOUNT_BILLING_CITY.fieldApiName]: this.address.localidade,
                [ACCOUNT_BILLING_COUNTRY.fieldApiName]: 'Brasil',
                [ACCOUNT_BILLING_STATE.fieldApiName]: this.address.uf,
                [ACCOUNT_BILLING_STREET.fieldApiName]: this.address.logradouro,
                [ACCOUNT_BILLING_ZIPCODE.fieldApiName]: this.address.cep,
                [ACCOUNT_ID.fieldApiName]: this.recordId
            }

            await updateRecord({fields});

            this.dispatchEvent(
                new ShowToastEvent({
                    title:'Success',
                    message: 'Address updated',
                    variant: 'success'
                })
            );

        } catch (error) {
            console.error(error);
        }
    }
}