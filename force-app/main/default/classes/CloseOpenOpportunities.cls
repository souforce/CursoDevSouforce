public with sharing class CloseOpenOpportunities implements Database.Batchable<sObject> {
    public CloseOpenOpportunities() {

    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        String query='Select Id, StageName from Opportunity where lastModifiedDate <= last_n_days:1 and StageName != \'Closed\'';

        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Opportunity> opps = new List<Opportunity>();

        for(sObject obj : scope){
            Opportunity opp = (Opportunity) obj;

            opp.StageName = 'Closed';

            opps.add(opp);
        }

        update opps;
    }

    public void finish(Database.BatchableContext BC){

    }
}