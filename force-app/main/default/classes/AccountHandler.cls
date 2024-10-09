public class AccountHandler {

    public static Account insertNewAccount(String accountName){
        
        try{
            Account acct = new Account(Name = accountName);
            insert acct;
            return acct;
        } Catch (DmlException e){
            system.debug('A DML exception has occured: '+ e.getMessage());
            return null;
        }
        
        
    }
}