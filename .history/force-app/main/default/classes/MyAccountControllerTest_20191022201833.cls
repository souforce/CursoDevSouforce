/**
    1 - Inserir contas
            Ter a possibilidade de inserir uma ou mais contas e retornar os ids das contas inseridas
    2 - Buscar contas
            Podendo ou não receber os ids por parametro e retornar uma lista de contas
    3 - Atualizar contas
            Receber uma ou mais, realizar o update e retornar se teve sucesso ou não da execução
    3 - Delete contas
            Receber uma ou mais, realizar o delete e retornar se teve sucesso ou não da execução
 */

@IsTest
public class MyAccountControllerTest {
   @IsTest
   static void testInsertAccount(){
       Account account1 = new Account(Name = 'Test1');
       Account account2 = new Account(Name = 'Test2');
       Account account3 = new Account(Name = 'Test3');

       List<Account> myAccounts = new List<Account>{account1, account2, account3};
       
       MyAccountController controller = new MyAccountController();

       List<String> insertedIds = controller.insertAccounts(myAccounts);

       System.assert(!insertedIds.isEmpty());
   }
}
