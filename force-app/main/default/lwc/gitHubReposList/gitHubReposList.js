import { LightningElement, wire } from "lwc";
import fetchGitHubRepos from "@salesforce/apex/GitHubRepoController.fetchGitHubRepos";

// Table corresponding to the 'GitHub Repos' external object
const columns = [
  {
    label: "Repository Name",
    fieldName: "DisplayUrl",
    type: "url",
    typeAttributes: {
      tooltip: { fieldName: "DisplayUrl" },
      label: { fieldName: "Name__c" },
      target: { fieldName: "DisplayUrl" },
    },
    initialWidth: 300,
    hideDefaultActions: true,
  },
  { label: "Description", fieldName: "Description__c", type: "text" },
  {
    label: "Last Pushed date",
    fieldName: "Last_Pushed_Date__c",
    type: "date",
    typeAttributes: {
      year: "numeric",
      month: "short",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit",
    },
    initialWidth: 250,
    hideDefaultActions: true,
  },
  {
    label: "Language",
    fieldName: "Language__c",
    type: "text",
    initialWidth: 150,
    hideDefaultActions: true,
  },
  {
    label: "Open Issues",
    fieldName: "OpenIssuesCount__c",
    type: "number",
    initialWidth: 120,
    hideDefaultActions: true,
  },
  {
    label: "Stars",
    fieldName: "Stars__c",
    type: "number",
    initialWidth: 120,
    hideDefaultActions: true,
  },
];

export default class GitHubReposList extends LightningElement {
  error;
  columns = columns;
  @wire(fetchGitHubRepos) gitHubRepos;
}
