@isTest
public with sharing class AddPrimaryContactTest {
    @TestSetup
    static void setup(){
        List<Account> testAccountsNY = new List<Account>();
        for(Integer i = 0; i < 50; i++){
            testAccountsNY.add(new Account(Name = 'Test Account NY' + i, BillingState = 'NY'));
        }
        insert testAccountsNY;

        List<Account> testAccountsCA = new List<Account>();
        for(Integer i = 0; i < 50; i++){
            testAccountsCA.add(new Account(Name = 'Test Account CA' + i, BillingState = 'CA'));
        }
        insert testAccountsCA;
    }

    @isTest
    static void testAddPrimaryContact(){
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact');
        String stateAbbreviation = 'CA';

        Test.startTest();
        AddPrimaryContact job = new AddPrimaryContact(testContact, stateAbbreviation);
        System.enqueueJob(job);
        Test.stopTest();

        // Assert that a Contact record was inserted for each of the 50 Accounts with BillingState 'CA'
        List<Contact> insertedContacts = [SELECT Id, Account.BillingState FROM Contact WHERE Account.BillingState = :stateAbbreviation];
        System.assertEquals(50, insertedContacts.size(), 'Incorrect number of contacts inserted');
    }

}