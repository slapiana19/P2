public class ValidateAppointment {
    public static void checkTime(List<Appointment__c> newAppointments)
    {      
        Set<Id> appointmentIds = new Set<Id>();
        for(Appointment__c a : newAppointments)
        {
            appointmentIds.add(a.Doctor__c);
        }
        integer numOfApps = newAppointments.size();
        List <Appointment__c> times = [SELECT Time__c,Date__c FROM Appointment__c WHERE Doctor__c=:appointmentIds LIMIT :numOfApps];
       //  List <Appointment__c> dates = [SELECT Date__c FROM Appointment__c WHERE Id=:appointmentIds];
System.debug('times and dates : ' + times);
        
        for(Appointment__c a : times)
        {
            System.debug('in first for loop : ');

            for(Appointment__c app: newAppointments)
            {
           System.debug('in second : ');

                if(app.Time__c==a.Time__c && app.Date__c==a.Date__c)
                {
                               System.debug('record is not inserting : ');

                    app.addError('Sorry the selected doctor is busy at that time, Please pick a different time.');
                }
            }
        }
    }

}