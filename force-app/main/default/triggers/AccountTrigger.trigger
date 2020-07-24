trigger AccountTrigger on Account (before insert, after insert) {

    if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT){
        
        AccountTriggerHandler.onBeforeInsert(Trigger.new,Trigger.newMap);
    }
    if(Trigger.operationType == System.TriggerOperation.AFTER_INSERT){
        
        AccountTriggerHandler.onAfterInsert(Trigger.new,Trigger.newMap);
    }

}