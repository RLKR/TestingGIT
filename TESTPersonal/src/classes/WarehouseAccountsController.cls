public with sharing class WarehouseAccountsController {
 
 private List<Account> accounts;
    
    public Decimal lat {get; set;}
    public Decimal lng {get; set;}
    
    public WarehouseAccountsController() {}
    
    public List<Account> getAccounts() {
       // String q = 'SELECT ID, Name, ShippingStreet, ShippingCity from Account WHERE DISTANCE(Location__c, GEOLOCATION('+String.valueOf(lat)+','+String.valueOf(lng)+'), \'mi\') < 100';
        //return Database.query(q);
        if(accounts != null) { 
            return accounts;
        }
        
        if(lat == null || lng == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Latitude or Longitude not set'));
        } else {
            String q = 'SELECT ID, Name, ShippingStreet, ShippingCity from Account WHERE DISTANCE(Location__c, GEOLOCATION('+String.valueOf(lat)+','+String.valueOf(lng)+'), \'mi\') < 100';
            accounts = Database.query(q);
            if(accounts.size() == 0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'No records found'));
            }
        }
        return accounts;
    }
}