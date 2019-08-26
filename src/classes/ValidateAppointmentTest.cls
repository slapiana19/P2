@isTest
public class ValidateAppointmentTest {
	@testSetup
    public static void setup(){
        //create doctor to make appointments with
        Doctor__c doctor = new Doctor__c(Name='Dr.Jeffmanson', Address__c='123 street st., Hell, Michigan');
        insert doctor;
        //insert dummy appointment
        Date tomorrow = Date.today().addDays(13);
        Appointment__c dummyAppointment = makeAppointmentOnDate(tomorrow);
        insert dummyAppointment;
         
    }
    
    public static Appointment__c makeAppointmentOnDate(Date appointmentDate){
        Time onePM = Time.newInstance(13, 0, 0, 0); 
        Doctor__c doctor = [SELECT id FROM Doctor__c LIMIT 1];
        Appointment__c appointment = new Appointment__c(Name='Dummy', Date__c = appointmentDate, Time__c=onePM, Doctor__c=doctor.id);
        return appointment;
    }
    
    @isTest
    public static void validateAppointmentTest(){
        // create appointments to test with
        Date pastDate = Date.newInstance(2019, 8, 22);
        Date tomorrow = Date.today().addDays(1); 
        Appointment__c apptInPast = makeAppointmentOnDate(pastDate);
        Appointment__c apptTomorrow = makeAppointmentOnDate(tomorrow);
        
        // test
        Integer initialNumberOfAppointments = [SELECT id FROM Appointment__c].size();
        // we attempt to insert the past appointment and assert that the number of appointments hasnt changed
        try{
        	insert apptInPast;
        } //this insert should fail
        catch(System.DmlException e){}
        Integer finalNumberOfAppointments = [SELECT id FROM Appointment__c].size();
        System.assertEquals(initialNumberOfAppointments, finalNumberOfAppointments);
        
        //test that inserting future appointment is successful
        initialNumberOfAppointments = [SELECT id FROM Appointment__c].size();
        insert apptTomorrow;
        finalNumberOfAppointments = [SELECT id FROM Appointment__c].size();
        System.assertEquals(initialNumberOfAppointments+1, finalNumberOfAppointments); // there should be one more appointment than there was initially
		
		//we now try to insert the same appointment again, it should fail because a doctor cannot have two appointments at same time
		initialNumberOfAppointments = [SELECT id FROM Appointment__c].size();
        try{
            insert apptTomorrow;}
        catch(System.DmlException e){}
        finalNumberOfAppointments = [SELECT id FROM Appointment__c].size();
        System.assertEquals(initialNumberOfAppointments, finalNumberOfAppointments); //insert should have failed
		        
       
    }
}