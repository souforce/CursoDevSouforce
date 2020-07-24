public  class MyAccountController {
    
    public List<String> insertAccounts(List<Account> accountList){
        List<String> insertedIds = new List<String>();

        insert accountList;

        for(Integer i = 0; i < accountList.size(); i++){
            insertedIds.add(accountList[i].Id);
        }

        return insertedIds;
    }

}
