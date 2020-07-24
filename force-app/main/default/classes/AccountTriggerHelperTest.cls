@IsTest
public class AccountTriggerHelperTest {

    @IsTest
    static void formatPhoneTest(){

        Account acc = new Account(Name='Acc Test',Phone='11987654321');

        Test.startTest();
            
            AccountTriggerHelper.formatPhone(acc);

            System.assertEquals(acc.Phone, '(11) 98765-4322','Output phone not right');

        Test.stopTest();



    }

}
