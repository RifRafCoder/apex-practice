public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        Map<Id, Integer> accountContactCountMap = new Map<Id, Integer>();
        
        // Query for contact counts for each account
        for (AggregateResult ar : [SELECT AccountId, COUNT(Id) contactCount FROM Contact WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            accountContactCountMap.put((Id)ar.get('AccountId'), (Integer)ar.get('contactCount'));
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        
        // Update accounts with contact counts
        for (Id accId : accountIds) {
            Integer contactCount = accountContactCountMap.containsKey(accId) ? accountContactCountMap.get(accId) : 0;
            Account acc = new Account(Id = accId, Number_Of_Contacts__c = contactCount);
            accountsToUpdate.add(acc);
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
