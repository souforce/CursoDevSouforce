@IsTest
public class TravelAccountQueueableTest {
    
    @TestSetup
    static void makeData(){
        Product2 testProduct = new Product2(Name='Holiday Package 1', IsActive=true, ProductCode='1');
        Product2 testProduct2 = new Product2(Name='Holiday Package 2', IsActive=true, ProductCode='2');

        insert new List<Product2> {testProduct, testProduct2};

        Pricebook2 priceBook = new Pricebook2(Name='United States PriceBook', IsActive=true);

        insert priceBook;

        PricebookEntry standardPriceProduct = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id = testProduct.Id, IsActive=true, UnitPrice=1);
        PricebookEntry standardPriceProduct2 = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id = testProduct2.Id, IsActive=true, UnitPrice=1);
        PricebookEntry customPriceProduct = new PricebookEntry(Pricebook2Id=priceBook.Id, Product2Id = testProduct.Id, IsActive=true, UnitPrice=1);
        PricebookEntry customPriceProduct2 = new PricebookEntry(Pricebook2Id=priceBook.Id, Product2Id = testProduct2.Id, IsActive=true, UnitPrice=1);

        insert new List<PricebookEntry>{standardPriceProduct,standardPriceProduct2,customPriceProduct,customPriceProduct2};

        Account accTest = new Account(Name='Acc Test', TargetCountry__c='United States', Phone='11111111111');
        insert accTest;
    }
    
    @IsTest
    static void testCreateOpportunities(){

        Account acc = [Select Id from Account limit 1];

        Test.startTest();
            System.enqueueJob(new TravelAccountQueueable([Select Id, TargetCountry__c from Account]));
            List<Opportunity> oppBeforeExecute = [select Id from Opportunity where AccountId =: acc.Id];

            System.assert(oppBeforeExecute.isEmpty());
        Test.stopTest();

        List<Opportunity> oppAfterExecute = [select Id from Opportunity where AccountId =: acc.Id];
        System.assert(!oppAfterExecute.isEmpty());

    }
}
