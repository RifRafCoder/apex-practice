trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> tasksToInsert = new List<Task>();
    switch on Trigger.operationType{
        when AFTER_INSERT{
           for(Opportunity opp : Trigger.new){
                if(opp.StageName == 'Closed Won'){
                    tasksToInsert.add(new Task(
                                    Subject = 'Follow Up Test Task',
                                    WhatId = opp.Id
                    ));
                }
           }
        }

        when AFTER_UPDATE{
            for(Opportunity opp : Trigger.new){
                //make sure old opp thats already at closed won, doesn't get updated again
                Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
                if(opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won'){
                    tasksToInsert.add(new Task(
                                    Subject = 'Follow Up Test Task',
                                    WhatId = opp.Id
                    ));
                }
            }
        }
    }

    if(tasksToInsert.size() > 0){
        insert tasksToInsert;
    }
}