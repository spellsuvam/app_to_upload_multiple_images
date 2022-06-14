class clinicDetailsOfDoctor{
     clinicName;
     country;
      state;
     addressLine;
     zipCode;
     googleMapLink;
     appointmentDuration;
     normalAppointmentCharge;
     emergencyCharge;
     availableDays;
    ClinicDetailsOfDoctor({        
        clinicName,
     country,
      state,
     addressLine,
     zipCode,
     googleMapLink,
     appointmentDuration,
     normalAppointmentCharge,
     emergencyCharge,
     availableDays,}
    ){
        this.clinicName=clinicName;
        this.addressLine=addressLine;
        this.appointmentDuration=appointmentDuration;
        this.country=country;
        this.emergencyCharge=emergencyCharge;
        this.googleMapLink=googleMapLink;
        this.normalAppointmentCharge=normalAppointmentCharge;
        this.state=state;
        this.zipCode=zipCode;
        this.availableDays=availableDays;
        
    };
}
let clinic1= new clinicDetailsOfDoctor();

class AvailableDay {
    AvailableDay()
}