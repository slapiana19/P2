public class GetDoctors1 {	
    
    public GetDoctors1(ApexPages.StandardController stdController) {
            	 String theName = System.currentPagereference().getParameters().get('name');

    }

	public String doctorName
    {
        get;
        //NOTE : when expanding a setter within a property you have to explicitly set its value 
        set{
            doctorName = value;
        
        }
    }

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
        System.debug('Search criteria:' + searchCriteria);
        doctors = [SELECT Name,Address__c,Supported_Illnesses__c FROM Doctor__c WHere Name Like :searchCriteria AND Address__c Like :filterCriteria];
    }

}