@IsTest
public class AccountTriggerTest {
    @IsTest
    static void testAccountInsert(){
        Account acc01 = new Account(Name='Acc 01', Phone=null);
        Account acc02 = new Account(Name='Acc 02', Phone='1111111111');
        Account acc03 = new Account(Name='Acc 03', Phone='11111111111');

        List<Account> accountToInsert = new List<Account>{acc01, acc02, acc03};

        Test.startTest();
            Database.SaveResult[] insertResults = Database.insert(accountToInsert, false);
        Test.stopTest();

        Database.SaveResult acc01InsertResult = insertResults[0];
        Database.SaveResult acc02InsertResult = insertResults[1];
        Database.SaveResult acc03InsertResult = insertResults[2];

        System.assert(!acc01InsertResult.isSuccess() && !acc02InsertResult.isSuccess());
        System.assert(acc01InsertResult.getErrors()[0].getMessage() == 'Por favor informar o telefone');
        System.assert(acc02InsertResult.getErrors()[0].getMessage() == 'Por favor informar o telefone com o DDD');
        System.assert(acc03InsertResult.isSuccess());

        Account acc03AfterInsert = [SELECT Phone From Account where Id =: acc03InsertResult.getId()];

        System.assert(acc03AfterInsert.Phone == '(11) 11111-1111');

    }
}
