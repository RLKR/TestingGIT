public with sharing class WarehouseExportController {
 
    public transient  List<Merchandise__c> Merchandise { get; private set; }

   // public WarehouseExportController() {
     //   Merchandise = [SELECT Name, Quantity__c, Price__c FROM Merchandise__c];
    //}
    public WarehouseExportController() {
        Boolean beRandom = ApexPages.currentPage().getParameters().get('random') != null;
        if(beRandom) {
            Merchandise = new List<Merchandise__c>();
            for(Integer x = 0; x < 1500; x++) {
                Merchandise__c m = new Merchandise__c(Name='Widget '+String.valueOf(x), Quantity__c=100, Price__c=49.99);
                Merchandise.add(m);
            }
        } else {
            merchandise = [SELECT Name, Quantity__c, Price__c FROM Merchandise__c LIMIT 10000];
        }
 
    }
    @isTest
    static public void testCSVController() {
        //load data
        Merchandise__c m1 = new Merchandise__c(Name='Rack Server',Price__c=1245.99,Quantity__c=500);
        Merchandise__c m2 = new Merchandise__c(Name='Deluxe Rack Server',Price__c=3245.99,Quantity__c=500);
        insert new Merchandise__c[]{m1,m2};
        
        //run logic
        Test.setCurrentPage(Page.InventoryExport);
        WarehouseExportController cvsc = new WarehouseExportController();
        
        //assertion: allMerchandise is not empty
        System.assertNotEquals(cvsc.Merchandise.size(),0);
        
        ApexPages.currentPage().getParameters().put('random', 'true');
        WarehouseExportController cvsc1 = new WarehouseExportController();
        
        //assertion: allMerchandise is 1500 long
        System.assertEquals(cvsc1.Merchandise.size(),1500);
        
    }
    
    /*@isTest
    static public void testCSVController() {
        //load data
        Merchandise__c m1 = new Merchandise__c(Name='Rack Server',Price__c=1245.99,Quantity__c=500);
        Merchandise__c m2 = new Merchandise__c(Name='Deluxe Rack Server',Price__c=3245.99,Quantity__c=500);
        insert new Merchandise__c[]{m1,m2};
        
        //run logic
        Test.setCurrentPage(Page.InventoryExport);
        WarehouseExportController cvsc = new WarehouseExportController ();
        
        //assertion: allMerchandise is not empty
        System.assertNotEquals(cvsc.Merchandise.size(),0);
    }*/
}