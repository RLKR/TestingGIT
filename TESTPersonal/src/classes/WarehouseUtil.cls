global class WarehouseUtil {
 
  @isTest
  static public void testDatedInvoices() {
         //load test data
 List<Invoice__c> invoices = Test.loadData(Invoice__c.sObjectType, 'InvoiceData');
        update invoices;
    //Data checking utilties
    
        //run logic
 
        //Assertion 1: Open records > 90 days have been set to "Archived"
        List<Invoice__c> invoices1 = [SELECT ID FROM Invoice__c WHERE Status__c = 'Archived'];
        System.assertNotEquals(0,invoices1.size());
                
 
        //Assertion 2: Closed records > 90 days have been deleted
        invoices = [SELECT ID FROM Invoice__c];
        System.assertEquals(0,invoices.size());
 
    }
 
}