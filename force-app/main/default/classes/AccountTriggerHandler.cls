public  class AccountTriggerHandler {

    public static void onBeforeInsert(List<Account> newAccountList, Map<Id,Account> newAccountMap){
        for(Account newAccount : newAccountList){
            if(newAccount.Phone == null) {
                newAccount.addError('Por favor informar o telefone');
                
            }else if(newAccount.Phone.length() < 11){
                newAccount.addError('Por favor informar o telefone com o DDD');
            }else{
                AccountTriggerHelper.formatPhone(newAccount);
            }

        }
    }

    public static void onAfterInsert(List<Account> newAccountList, Map<Id,Account> newAccountMap){

        List<Account> travelAccountList = new List<Account>();

        for(Account newAccount : newAccountList){
            if(newAccount.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Travel_Detail').getRecordTypeId()){
                travelAccountList.add(newAccount);
            }
        }

        System.enqueueJob(new TravelAccountQueueable(travelAccountList));
        
    }
}