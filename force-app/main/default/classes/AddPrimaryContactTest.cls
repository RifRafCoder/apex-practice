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
            testAccountsCA.add(new Account(Name = 'Test Account CA' + i, BillingState = 'NY'));
        }
        insert testAccountsNY;
    }
}