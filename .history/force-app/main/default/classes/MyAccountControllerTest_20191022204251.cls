@IsTest
public class MyAccountControllerTest {
    
    @IsTest
    static void testInsertAccount(){
        Account account1 = new Account(Name='Test1');
        Account account2 = new Account(Name='Test2');
        Account account3 = new Account(Name='Test3');

        List<Account> accountList = new List<Account>{account1, account2, account3};

        MyAccountController controller = new MyAccountController();

        List<String> createdIds = controller.insertAccounts(accountList);

        System.assert(!createdIds.isEmpty());
    }
}
