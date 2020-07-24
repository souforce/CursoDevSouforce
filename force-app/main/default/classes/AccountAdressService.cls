public with sharing class AccountAdressService {
    
    @AuraEnabled(continuation=true cacheable=true)
    public static Object beginSearchAddress(String zipCode){
        
        Continuation con = new Continuation(120);
        con.ContinuationMethod = 'endSearchAddress';

        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://viacep.com.br/ws/'+zipCode+'/json/');
        con.addHttpRequest(request);

        return con;

    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> endSearchAddress(List<String> labels, Object state){
        
        HttpResponse response = Continuation.getResponse(labels[0]);

        return (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
    }

}