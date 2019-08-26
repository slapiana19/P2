trigger AppointmentValidation on Appointment__c (before insert) {
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            ValidateAppointment.checkTime(Trigger.new);
        }
    }

}