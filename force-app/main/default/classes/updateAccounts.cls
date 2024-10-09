public class updateAccounts {
    public static void updateAccount(){
        List<Account> accToBeUpdated = new List <Account>();
        Set<Id> accIdSet = new Set<Id>();
        
        for(Contact con: [SELECT Id, Account.Id FROM Contact 
                          WHERE Name LIKE '%Test%' AND Account.Id != NULL]){
                              if(!accIdSet.contains(con.AccountId)){
                                  Account acc = new Account();
                                  acc.Id = con.AccountId;
                                  acc.Active__c = 'Yes';
                                  acc.Rating = 'Hot';
                                  accToBeUpdated.add(acc);
                                  accIdSet.add(con.AccountId);
                              }
                          }
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }

}