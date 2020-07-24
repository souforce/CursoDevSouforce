trigger helloWorldTrigger on Account (before insert, before update) {
    if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            // Process before update
            for(Account a : Trigger.new){
                if(Trigger.oldMap.get(a.Id).Type != a.Type){
                    a.addError('You cannot change the type field');
                }
            }
        } else if (Trigger.isAfter) {
            // Process after update
        }        
    }
    else if (Trigger.isInsert) {
        // Process before insert 
        helloWorldHandler.sayHello();
    }
}