public class MyVisualForceController {
    
    public String property {get;set;}
    
    public MyVisualForceController(){
        this.property = '';
    }
    
    public PageReference populateProperty(){
        this.property = 'World';
        return null;
    }
}