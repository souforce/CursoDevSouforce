public inherited sharing class SOQLInjectionController {

    public List<AccountWrapper> accounts {get;set;}
    public String inputName {get;set;}
    public String error {get;set;}
    public Decimal inputTotalRevenue {get;set;}

    public SOQLInjectionController() {
        accounts = new List<AccountWrapper>();
    }

    public PageReference searchAccounts(){
        String query = 'Select Id, Name, Phone From Account where Name like \'%' +String.escapeSingleQuotes(this.inputName)+ '%\'';

        try {
            accounts = new List<AccountWrapper>();
            for(Account acc: Database.query(query)){
                accounts.add(new AccountWrapper(acc));
            }
            //accounts = [SELECT Id, Name, Phone from Account where Name like : '%'+this.inputName+'%'];

        } catch (Exception e) {
            error = e.getMessage();
        }

        return null;
    }

    public class AccountWrapper{
        public Account acc;

        public AccountWrapper(Account acc){
            this.acc = acc;
        }

        public String AccName{
            get{

                return Schema.SobjectType.Account.fields.Name.isAccessible() ? acc.Name : '';
            }
        }

        public String AccPhone{
            get{
                return Schema.SobjectType.Account.fields.Phone.isAccessible() ? acc.Phone : '';
            }
        }

    }

}