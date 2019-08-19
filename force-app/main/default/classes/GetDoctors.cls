public class GetDoctors {	

	public String doctorName
    {
        get;
        //NOTE : when expanding a setter within a property you have to explicitly set its value 
        set{
            doctorName = value;
        
        }
    }
    /*public String doctorName
    {
        get;
        //NOTE : when expanding a setter within a property you have to explicitly set its value 
        set{
            doctorName = value;
        
        }
    }*/
    public String cityName
    {
		get;
        set{
            cityName = value;
        }
    }
    //retrieved doctors
    public List<Doctor__c> doctors
    {
        get; set;
    }
    //query for doctors based on user input of name and illness
    public void getDoctors()
    {
        String searchCriteria = doctorName + '%';
        String filterCriteria = '%' + cityName + '%';
        doctors = [SELECT Name,Address__c,Supported_Illnesses__c FROM Doctor__c WHere Name Like :searchCriteria AND Address__c Like :filterCriteria];
    }
    /*
    public void createAppointment()
    {
        Appointment__c appointment = new Appointment__c(
            Name = "New Doctor Appointment",
            CreatedById = ,
            Date_and_Time__c = opEvent.StartDate__c,
            Doctor__c = opEvent.End_Date__c,
            Subject = 'Go Live',
            Department_s_del__c = opEvent.Department__c,
            Product_s__c = opEvent.Product_s__c

        );
    }
*/
}