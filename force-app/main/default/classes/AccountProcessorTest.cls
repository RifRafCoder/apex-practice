@isTest
public class AccountProcessorTest {
    @isTest
    static void testCountContacts() {
        // Test data setup
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;

        List<Contact> testContacts = new List<Contact>();
        for (Account acc : testAccounts) {
            for (Integer i = 0; i < 3; i++) {
                testContacts.add(new Contact(AccountId = acc.Id, LastName = 'Test Contact ' + i));
            }
        }
        insert testContacts;

        List<Id> accountIds = new List<Id>();
        for(Account acc : testAccounts){
            accountIds.add(acc.Id);
        }

        Test.startTest();
        // Invoke the future method
        
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        // Verify the results
        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :testAccounts];
        System.assertEquals(testAccounts.size(), updatedAccounts.size(), 'Number of updated accounts is incorrect');
        for (Account acc : updatedAccounts) {
            System.assertEquals(3, acc.Number_Of_Contacts__c, 'Number of contacts per account is incorrect');
        }
    }
}
