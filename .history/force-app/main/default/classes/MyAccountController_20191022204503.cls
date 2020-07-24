public class MyAccountController {
    
    public List<String> insertAccounts(List<Account> accounts){
        List<String> createdIds = new List<String>();

        insert accounts;

        for(Account acc : accounts){
            createdIds.add(acc.Id);
        }

        return  createdIds;
    }

}
