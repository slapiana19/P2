@isTest
public class GetDoctorsTest {
    
    @testSetup
    public static void setup(){
        List<String> doctorNames = new List<String>{'Dr.Beefman', 'Dr.Grumblestein', 'Dr.Beetman', 'Dr.Greeb', 'Dr.Alfonso'};
        List<String> doctorAddresses = new List<String>{'3012 Lincoln Blvd., Cle. Hts., OH, 44118', '3041 Berkshire Rd., Cle. Hts., OH, 44118', 
                '126 Hesketh St., Chevy Chase, MD, 20815', '4912 7th Pl NE, DC',  
                '626 Hamilton St NW, DC'};
                  //  List<String> illnessNames = new List<String>{'Flu', 'Meningitis', 'Pneumonia', 'Poison Ivy', 'Flu'};           
        List<Doctor__c> doctors = new List<Doctor__c>();
        for(Integer i=0; i<5; i++){
            doctors.add(new Doctor__c(Name=doctorNames[i], Address__c=doctorAddresses[i]));
        }
        
        insert doctors;
        
    }
    
    @isTest
    public static void getDoctorsTest(){
        List<Doctor__c> doctors = [SELECT Name FROM Doctor__c];
        system.debug(doctors);
        GetDoctors GDInstance = new GetDoctors();
        GDInstance.doctorName = 'Dr.'; //doctorName is the search term to be input
        GDInstance.cityName = '';
        GDInstance.getDoctors(); //perform search

        System.assertEquals(5, GDInstance.doctors.size()); //the resulting list should contain all 5 doctors
        
        GDInstance.doctorName= 'Dr.Be'; // this search term should return two doctors
        GDInstance.getDoctors(); //perform search
        System.assertEquals(2, GDInstance.doctors.size());
        
        // we will now search by cityName
        GDInstance.doctorName = '';
        GDInstance.cityName = 'DC';
        GDInstance.getDoctors(); // this search should return two doctors
        System.assertEquals(2, GDInstance.doctors.size());
    }
    
}