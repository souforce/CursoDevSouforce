public class AccountTriggerHelper {
    //new commit feature
    //new commit feature 2
    public static void formatPhone(Account account){

        String areaCode = account.phone.substring(0,2);
        String firstPart = account.phone.substring(2,7);
        String secondPart = account.phone.substring(7);

        account.phone = String.format('({0}) {1}-{2}', new List<Object>{areaCode, firstPart, secondPart});

    }
}