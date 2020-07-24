@IsTest
public class ReceitaAPITest {
    
    @IsTest
    static void testCallApi200Response(){
        Test.startTest();
            String cnpj = '12345679822';
            Test.setMock(HttpCalloutMock.class, new ReceitaAPIMock(200,'OK'));
            TOReceitaAPI responseTO = ReceitaAPI.callReceitaAPI(cnpj);
            System.assert(responseTO.status != 'ERROR');
        Test.stopTest();
    }

    @IsTest
    static void testCallApi201Response(){
        Test.startTest();
            String cnpj = '12345679822';
            Test.setMock(HttpCalloutMock.class, new ReceitaAPIMock(201,'OK'));
            TOReceitaAPI responseTO = ReceitaAPI.callReceitaAPI(cnpj);
            System.assert(responseTO == null);
        Test.stopTest();
    }

    @IsTest
    static void testCallApi429Response(){
        Test.startTest();
            String cnpj = '12345679822';
            Test.setMock(HttpCalloutMock.class, new ReceitaAPIMock(429,'ERROR'));
            TOReceitaAPI responseTO = ReceitaAPI.callReceitaAPI(cnpj);
            System.assert(responseTO.status == 'ERROR');
        Test.stopTest();
    }

    @IsTest
    static void testCallApiHandleException(){
        Test.startTest();
            String cnpj = '12345679822';
            TOReceitaAPI responseTO = ReceitaAPI.callReceitaAPI(cnpj);
            System.assert(responseTO.status == 'ERROR');
        Test.stopTest();
    }
}
