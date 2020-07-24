/**
    1 - Inserir contas
            Ter a possibilidade de inserir uma ou mais contas e retornar os ids das contas inseridas
 */

@IsTest
public class MyAccountControllerTest {
   @IsTest
   static void testInsertAccount(){
       Account account1 = new Account(Name = 'Test1');
       Account account2 = new Account(Name = 'Test2');
       Account account3 = new Account(Name = 'Test3');

       List<Account> myAccounts = new List<Account>{account1, account2, account3};

       List<Id> insertedIds;

       System.assert(!insertedIds.isEmpty());
   }
}
