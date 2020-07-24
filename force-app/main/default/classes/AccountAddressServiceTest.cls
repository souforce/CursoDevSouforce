@IsTest
public class AccountAddressServiceTest {
    
    @IsTest
    static void testSearchAccountAddress(){
        Test.startTest();
            String cep = '01001-000';
            Continuation con = (Continuation) AccountAdressService.beginSearchAddress(cep);
            List<String> requestLabels = new List<String>(con.getRequests().keySet());

            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody('{"cep":"01001-000","logradouro":"Praça da Sé","complemento":"lado ímpar","bairro":"Sé","localidade":"São Paulo","uf":"SP","unidade":"","ibge":"3550308","gia":"1004"}');

            Test.setContinuationResponse(requestLabels[0], response);

            Map<String, Object> responseResult = (Map<String,Object>) AccountAdressService.endSearchAddress(requestLabels, null);
            String resultCep = (String) responseResult.get('cep');
            System.assert(cep == resultCep);

        Test.stopTest();
    }

}
