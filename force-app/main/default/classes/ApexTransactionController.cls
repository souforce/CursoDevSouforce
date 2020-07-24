public with sharing class ApexTransactionController {
    public static void saveAccount() {

        System.debug('Method Started');

        //Inserir uma conta
        Account account = new Account(Name='Test Apex Transaction Acc', Phone='11111111111');
        insert account;

        Contact contact = new Contact(Account= account);
        insert contact;

        Case caseAccount = new Case(Account=account, Subject='Test Apex Transaction Case');
        insert caseAccount;

        System.debug('Method Finished');

    }
}