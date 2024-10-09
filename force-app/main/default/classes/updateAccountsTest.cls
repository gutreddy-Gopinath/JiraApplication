@isTest
public class updateAccountsTest {
    @isTest
    private static void testUpdateAccount(){
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Active__c = 'No';
        acc.Rating = 'Cold';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = 'Test';
        con.AccountId = acc.id;
        insert con;
        
        updateAccounts.updateAccount();
        
        Account updateAcc = [SELECT Id, Active__c, Rating FROM Account WHERE Id =: acc.Id];
        system.assertEquals('Hot', updateAcc.Rating);
    }

}