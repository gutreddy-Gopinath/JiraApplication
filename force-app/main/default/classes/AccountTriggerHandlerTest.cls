@isTest
public class AccountTriggerHandlerTest {
	@testSetup
    private static void setup(){
        
        List<Account> accList = new List<Account>();
        for(Integer i=0; i<3; i++){
            Account acc = new Account();
            acc.Name = 'Test'+ i;
            acc.BillingCity = 'Test City';
            acc.BillingCountry = 'Test COuntry';
            acc.BillingState = 'Test state';
            acc.BillingStreet = 'Test street';
            acc.BillingPostalCode = '123456';
            if(i==0){
                acc.CopyBillingAddToShipping__c = true;
            }
            accList.add(acc);
        }
        insert accList;
            
    }
    
    @isTest
    private static void copyBillingToShippingUpdateTest(){
        
        Account acc = [SELECT Id, BillingCity, CopyBillingAddToShipping__c FROM Account WHERE Name = 'Test1'LIMIT 1];
                
        Test.startTest();
        acc.CopyBillingAddToShipping__c=true;
        update acc;
        Test.stopTest();
        
        Account updateAcc = [SELECT Id, ShippingCity FROM Account WHERE Id =: acc.Id];
        System.assertEquals(acc.BillingCity, updateAcc.ShippingCity);
    }
}