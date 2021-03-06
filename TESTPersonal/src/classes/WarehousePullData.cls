public with sharing class WarehousePullData {
 
    public WarehousePullData() {}
        //WarehousePullData.pullData();
    public static String pullData() {       
        // Instantiate a new http object
            Http h = new Http();
 
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
            HttpRequest req = new HttpRequest();
            req.setEndpoint('http://warehousedatapush.herokuapp.com/');
            req.setMethod('GET');
 
        // Send the request, and return a response
            HttpResponse res = h.send(req);
            Map<String, Object> data = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());  
        
            List<Object> items = (List<Object>)data.get('Items');
            List<Merchandise__c> new_items = new List<Merchandise__c>();
            for(Object item : items) {
                Map<String, Object> item_data = (Map<String, Object>)item;
                Merchandise__c merch = new Merchandise__c();
                merch.Name = (String)item_data.get('Name');
                merch.Quantity__c = (Decimal)item_data.get('Quantity');
                merch.Price__c = (Decimal)item_data.get('Price');
                new_items.add(merch);
            }
            
            
            insert new_items;
            return 'Done';
    }
    static public Boolean createBaselineData() {
        Merchandise__c m = new Merchandise__c(Name='Rack Server',Price__c=1245.99,Quantity__c=500);
        insert m;
        
        Invoice__c i = new Invoice__c();
        insert i;
        
        Line_Item__c li = new Line_Item__c(Name='1',Quantity__c=10,Merchandise__c=m.Id,Invoice__c=i.Id);
        insert li;
        
        return true;    
    }
 
 
    @isTest
    public static void testPullData() {
    Test.startTest();
    // Set mock callout class  
    Test.setMock(HttpCalloutMock.class, new WarehouseMock());
 
    // Call class that utilizes this endpoint 
    WarehousePullData.pullData();
Test.stopTest();
    WarehousePullData.createBaselineData();
        
List<Merchandise__c> merchandise = Test.loadData(Merchandise__c.sObjectType, 'MerchData');
update merchandise;
        //List<Merchandise__c> merch = [SELECT ID from Merchandise__c WHERE Name = 'Super Laptop'];
        
       // System.assertEquals(merch.size(),1);
        List<Merchandise__c> merch = [SELECT ID from Merchandise__c WHERE Name = 'Laptop From Endpoint'];
        
System.assertEquals(merch.size(),1);
    }
}