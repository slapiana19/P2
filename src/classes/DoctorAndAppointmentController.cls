public class DoctorAndAppointmentController {
    public boolean settingAppointment{
        get;
        set;
    }
    
    public String appointmentName{
        get;
        set {
            appointmentName = value;
            System.debug('Appointment Name: ' + appointmentName);
        }
    }
    
    public date appointmentDate{
        get;
        set;
    }
    
    public time appointmentTime{
        get;
        set;
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
        get; 
        set{
            doctors = value;
            List<SelectOption> names = new List<SelectOption>(); //we will use this to automatically populate this.doctorNames
            for (Doctor__c doctor : doctors){
                names.add(new SelectOption(doctor.Name, doctor.Name + ', Address: ' + doctor.Address__c + ', Treats: ' + doctor.Supported_Illnesses__c));
            }
            this.doctorNames = names; //set doctorNames
        }
    }
    
    public List<SelectOption> doctorNames{
        //if the user has not yet searched for doctors the list of doctors should say none selected
        get{
            SelectOption defaultOption = new SelectOption('default', 'None Selected'); 
            if(doctorNames == null){ // user has not yet searched for doctors
                return new List<SelectOption>{defaultOption}; 
            }
            return doctorNames;
        }
            
        set;
    }
    
    public String selectedDoctorName{
        get;
        set{
            selectedDoctorName = value;
            Doctor__c selectedDoctor = [SELECT id, Name FROM Doctor__c WHERE Name =: selectedDoctorName];
            chosenDoctorId = selectedDoctor.id;
        }
    }
    
    public Id chosenDoctorId{
        get; 
        set{
            chosenDoctorId = value;
            System.debug('chosenDoctorId has been set to:' + chosenDoctorId);
        }
        
    }
    //query for doctors based on user input of name and illness
    public void getDoctors()
    {
        String searchCriteria = doctorName + '%';
        String filterCriteria = '%' + cityName + '%';
        System.debug('Search criteria:' + searchCriteria);
        doctors = [SELECT Name,Address__c,Supported_Illnesses__c FROM Doctor__c WHere Name Like :searchCriteria AND Address__c Like :filterCriteria];
    }
    
    //take users to 
    public void makeAppointment(){
        System.debug('chosenDoctorId is:'+chosenDoctorId);
        this.settingAppointment = true;
        //return Page.SetAppointment1;
    }
    
    //inputs new appointment with selected doctor, date and time
    public PageReference saveAppointment(){
        system.debug('save is called');
        Appointment__c appointment = new Appointment__c(Name=appointmentName, time__c=appointmentTime, date__c=appointmentDate, Doctor__c=chosenDoctorId);
        system.debug('appointment was created');
        insert appointment;
        system.debug('appointment was inserted');
        PageReference pg = new PageReference('/'+ appointment.Id);
        pg.setRedirect(true);
        return pg; 
    }

}