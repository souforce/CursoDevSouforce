public with sharing class AccountActivitiesSchedule implements Schedulable{
    public AccountActivitiesSchedule() {
        //commit on master
    }

    public void execute(SchedulableContext sc){
        List<Opportunity> opportunties = [SELECT AccountId, OwnerId From Opportunity where LastModifiedDate <= last_n_days:2 and StageName != 'Closed'];
        List<Task> taskToInsert = new List<Task>();

        for(Opportunity opp : opportunties){
            taskToInsert.add(new Task(WhatId=opp.accountId
                                    , OwnerId = opp.OwnerId
                                    , ActivityDate = System.now().addDays(1).date()
                                    , Subject='Follow-up'
                                )
            );
        }
        

        insert taskToInsert;

    }
}
