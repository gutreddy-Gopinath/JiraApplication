public class MyDemo{

    public static void countTotalSalary(){
        
        List<Account> accWithEmployees = [SELECT Id, Total_Salary__c, Name, (SELECT Id, Salary__c FROM Employees__r) 
                                          FROM Account 
                                          WHERE CreatedDate = THIS_YEAR];
        
        if(!accWithEmployees.isEmpty()){
            for(Account acc: accWithEmployees){
                Decimal TotalSal = 0;
                for(Employee__c emp: acc.Employees__r){
                    
                    TotalSal = TotalSal + emp.salary__c;
                }
                acc.Total_Salary__c = TotalSal;
            }
        }
        if(!accWithEmployees.isEmpty()){
            update accWithEmployees;
        }
    }
    
    public static void updateContactPhone(){
        List<Account> accList = [SELECT Id, Phone FROM Account WHERE CreatedDate = THIS_YEAR AND Phone!=null];
        Map<Id, Account> accIdToAccountMap = new Map<Id, Account>(accList);
        List<Contact> conList = [SELECT Id, Phone, AccountId From Contact
                                 WHERE AccountId IN: accIdToAccountMap.keySet()];
        
        List<Contact> contactToBeUpdated = new List<Contact>();
        if(!conList.isEmpty()){
            for(Contact con : conList){
                if(accIdToAccountMap.containsKey(con.AccountId)){
                    contact conRec = new contact();
                    conRec.Id = con.Id;
                    conRec.Phone = accIdToAccountMap.get(con.AccountId).Phone;
                    contactToBeUpdated.add(conRec);
                }
            }
        }
        if(!contactToBeUpdated.isEmpty()){
            update contactToBeUpdated;
        }
        
        
    }
}