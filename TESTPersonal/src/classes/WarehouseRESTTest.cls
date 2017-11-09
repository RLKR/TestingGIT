global class WarehouseRESTTest {
    @IsTest
    global static void testWarehouseREST() {    
        Merchandise__c m = new Merchandise__c(Name='Rack Server1',Price__c=12415.99,Quantity__c=5010);
        insert m;
        
        Invoice__c i = new Invoice__c();
        insert i;
        
        Line_Item__c li = new Line_Item__c(Name='1',Quantity__c=10,Merchandise__c=m.Id,Invoice__c=i.Id);
        insert li;
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        WarehouseREST.RESTMessage r = WarehouseREST.postMerchandiseToInvoice(i.id,new Id[]{m.id});
        System.assertEquals(r.status,'Completed');
        
        // pass the req and resp objects to the method       
        req.requestURI = 'https://www.salesforce.com/services/apexrest/WarehouseREST/'+i.Id;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        List<AggregateResult> get_results = WarehouseREST.getMerchandiseForInvoice();
        System.assertEquals(get_results.size(),1);
        
        // pass the req and resp objects to the method       
        req.requestURI = 'https://www.salesforce.com/services/apexrest/WarehouseREST/?iid='+i.Id+'&'+m.id;  
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;
        
            String r1 = WarehouseREST.deleteMerchandiseFromInvoice();
            System.assertEquals('Done',r1);
        
        
    }
}