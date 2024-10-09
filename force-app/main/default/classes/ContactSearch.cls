public class ContactSearch {

    public static List<Contact> searchForContacts(String lastName, String mailPostalCode){
        List<Contact> con = [SELECT Id, Name FROM Contact 
                             WHERE LastName =:lastName AND MailingPostalCode =:mailPostalCode];
      return con;
    }
}