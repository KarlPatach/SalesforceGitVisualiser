import { LightningElement, wire } from 'lwc';

import fetchCases from '@salesforce/apex/CaseController.fetchCases';

// Table corresponding to the 'Case' object
const columns = [
    {label: 'Priority', fieldName: 'Priority', type: 'text', sortable:true}, 
    {label: 'Subject', fieldName: 'Subject', type: 'text', wrapText: true},
    {label: 'Created date', fieldName: 'CreatedDate', type: 'date', sortable:true},
    {label: 'Status', fieldName: 'Status', type: 'text', sortable:true},
    {label: 'Pull Request', fieldName: 'Pull_Request__c'
        , type: 'url'
        , typeAttributes: { tooltip: { fieldName: 'Pull_Request__c' }
        , label: 'PR link'}},
];

export default class CasesList extends LightningElement {

    error;
    columns = columns;
    @wire(fetchCases) cases;
}