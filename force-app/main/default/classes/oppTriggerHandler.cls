public class oppTriggerHandler {
    
    public static void onAfterInsert(List<Opportunity> newList){
        set<Id> accIds = new set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp : newList){
            if(opp.AccountId != null){  
           		accIds.add(opp.AccountId);
            }
            
        }
        accToBeUpdated = calculateAnnualRevenue(accIds);
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
    public static void onAfterUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        set <Id> accIds = new set<Id>();
        List<Account> accToBeUpdated = new List <Account>();
        
        for (Opportunity opp :  newList){
            if(opp.AccountId != null && opp.Amount != oldMap.get(opp.Id).Amount){
                accIds.add(opp.AccountId);
            }
        }
        accToBeUpdated = calculateAnnualRevenue(accIds);
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
    public static void onAfterDelete(List<Opportunity> oldList){
        set<Id> accIds = new set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp : oldList){
            if(opp.AccountId !=null){
                accIds.add(opp.AccountId);
            }
        }
        accToBeUpdated = calculateAnnualRevenue(accIds);
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
        
    }
    
    public static List<Account> calculateAnnualRevenue(Set<Id> accIds){
        
        List<Account> accToBeUpdated = new List<Account>();
        Map<Id, Decimal> accIdToAnnualRevenue = new Map<Id, Decimal>();
        
        for(Opportunity opp : [SELECT Id, Amount, AccountId FROM Opportunity WHERE AccountId IN : accIds]){
            Decimal total = 0;
            if(accIdToAnnualRevenue.containsKey(opp.AccountId)){
                total = accIdToAnnualRevenue.get(opp.AccountId);
            }
            if(opp.Amount != null){
            total = total + opp.Amount;     
            }
            accIdToAnnualRevenue.put(opp.AccountId, total);
        }
        if(!accIdToAnnualRevenue.isEmpty()){
            for (Id i : accIdToAnnualRevenue.keySet()){
                Account acc = new Account();
                acc.id = i;
                acc.AnnualRevenue = accIdToAnnualRevenue.get(i);
                accToBeUpdated.add(acc);
            }
        }
                
        return accToBeUpdated;
    }
}