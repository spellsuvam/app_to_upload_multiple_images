import 'availableday.dart';
import 'clinicdetailsofdoctor.dart';
import 'timeslot.dart';

ClinicDetailsOfDoctor clinic1 = ClinicDetailsOfDoctor(
  clinicName: "rajisha clinic",
  addressLine: "godhawari",
  appointmentDuration: "15",
  country: "nepal",
  emergencyCharge: "500",
  googleMapLink: "www.map.com",
  state: "state 1",
  normalAppointmentCharge: "500",
  availableDays: [
    AvailableDay(workingDays: [
      "friday",
      "saturday"
    ], availableTimeSlots: [
      TimeSlot(startTime: "11:00", endTime: "2:00"),
      TimeSlot(startTime: "4:00", endTime: "6:00"),
      TimeSlot(startTime: "4:00", endTime: "6:00")
    ]),
    AvailableDay(
        workingDays: ["tuesday"],
        availableTimeSlots: [TimeSlot(startTime: "12:00", endTime: "4:00")])
  ],
);
