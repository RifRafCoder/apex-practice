public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext sc){
        List<Lead> blankLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
        for(Lead lead : blankLeads){
            lead.LeadSource = 'Dreamforce';
        }
        update blankLeads;
    }
}