@isTest
public class LeadProcessorTest {
    @TestSetup
    static void setup(){
        List<Lead> testLeads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            testLeads.add(new Lead(FirstName = 'TestFirstName' + i, LastName = 'TestLastName' + i, Company = 'TestCompany' + i));
        }
        insert testLeads;
    }

    @isTest
    static void testLeadProcessor() {
        Test.startTest();
        LeadProcessor batchJob = new LeadProcessor();
        Database.executeBatch(batchJob);
        Test.stopTest();

        //verify leads were updated
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead];
        for(Lead leads : updatedLeads){
            System.assertEquals('Dreamforce', leads.LeadSource, 'LeadSource not updated correctly');
        }

    }
}