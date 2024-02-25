@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2042';
    @TestSetup
    static void setup(){
        List<Lead> newLeads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            newLeads.add(new Lead(FirstName = 'TestFirstName' + i, LastName = 'TestLastName' + i, Company = 'TestCompany' + i));
        }
        insert newLeads;
    }

    @isTest
    static void testDailyLeadProcessor(){
        Test.startTest();
        DailyLeadProcessor scheduler = new DailyLeadProcessor();
        String jobId = System.schedule('ScheduledLeadUpdate', CRON_EXP, scheduler);
        Test.stopTest();

        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'Incorrect number of leads updated');
    }
}