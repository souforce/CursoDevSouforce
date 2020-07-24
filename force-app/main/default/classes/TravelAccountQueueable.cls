public class TravelAccountQueueable implements Queueable {

    List<Account> listAccount;

    public TravelAccountQueueable(List<Account> listAccount) {
        this.listAccount = listAccount;
    }

    public void execute(QueueableContext context){
        Map<String,String> priceBookNames = new Map<String,String>();

        for(Account acc: listAccount){
            priceBookNames.put(acc.Id, acc.TargetCountry__c + ' PriceBook');
        }

        Map<String,Pricebook2> priceBooksMap = new Map<String, PriceBook2> ();

        List<Pricebook2> priceBooks = [SELECT Id
                                        , Name
                                        , (
                                            SELECT Id
                                                    , Product2Id
                                                    , Product2.Name
                                                    , ProductCode
                                                    , UnitPrice
                                            FROM PricebookEntries
                                            WHERE IsActive = true
                                        )
                                        FROM Pricebook2
                                        WHERE Name in: priceBookNames.values()
                                    ];
        for(Pricebook2 priceBook : priceBooks){
            priceBooksMap.put(priceBook.Name, priceBook);
        }
        
        List<Opportunity> opps = new List<Opportunity>();

        for (String accId : priceBookNames.keySet()) {
            
            String priceBookName = priceBookNames.get(accId);
            Pricebook2 priceBook = priceBooksMap.get(priceBookName);

            for (PricebookEntry entry : priceBook.PriceBookEntries) {

                for (Integer i = 0; i < 15000; i++) {
                    
                }

                Opportunity opp = new Opportunity(Name='Opp '+entry.Product2.Name
                                                , AccountId = accId
                                                , CloseDate = System.today().addDays(30)
                                                , StageName = 'Prospecting'
                                                , Pricebook2Id = pricebook.Id
                                            );
                opps.add(opp);
            }
            
        }

        insert opps;

        List<OpportunityLineItem> oppItems = new List<OpportunityLineItem>();

        for (Opportunity opp : opps) {
            
            String priceBookName = priceBookNames.get(opp.accountId);
            Pricebook2 priceBook = priceBooksMap.get(priceBookName);

            for (PricebookEntry entry : priceBook.PriceBookEntries) {

                for (Integer i = 0; i < 15000; i++) {
                    
                }

                if(opp.Name.contains(entry.Product2.Name)){
                    oppItems.add(new OpportunityLineItem(OpportunityId = opp.Id
                                                                    , UnitPrice = entry.UnitPrice
                                                                    , Product2Id = entry.Product2Id
                                                                    , Quantity = 1
                                                            )
                    );
                }
                
            }
            
        }

        insert oppItems;
    }
}