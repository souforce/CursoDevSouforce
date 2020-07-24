public class AccountPDFController {

    Id accountId;

    public AccountPDFController() {
        this.accountId = ApexPages.currentPage().getParameters().get('Id');
    }

    public Account getCurrentAccount(){
        return [Select Name, WebSite, Phone From Account where id =: this.accountId ];
    }

    public List<String> getContactsInformation(){
        List<String> contactsInformation = new List<String>();
        String infoTemplate = 'Name: {0} {1} | Email: {2}';
        for(Contact con :[Select FirstName, LastName, Email from Contact where accountId =: this.accountId] ){
            contactsInformation.add( String.format( infoTemplate, new List<Object>{ con.FirstName, con.LastName, con.Email } ) );
        }
        return contactsInformation;
    }
}