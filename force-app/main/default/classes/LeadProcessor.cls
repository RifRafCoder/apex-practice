public with sharing class LeadProcessor implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, LeadSource FROM Lead]);
    }

    public void execute(Database.BatchableContext bc, List<Lead> leads){
        for(Lead lead : leads){
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }

    public void finish(Database.BatchableContext context){
        //optional logic
    }
}