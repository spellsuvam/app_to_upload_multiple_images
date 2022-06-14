import 'dart:developer';

import 'package:camera_app/heallivedoctormodeltest/availableday.dart';
import 'package:camera_app/heallivedoctormodeltest/clinicdetailsofdoctor.dart';
import 'package:camera_app/heallivedoctormodeltest/timeslot.dart';
import 'package:camera_app/heallivedoctormodeltest/workingdaysandshiftwidget.dart';
import 'package:flutter/material.dart';
import 'clinicdata.dart';

class UIToAddClinic extends StatefulWidget {
  const UIToAddClinic({Key? key}) : super(key: key);
  @override
  State<UIToAddClinic> createState() => _UIToAddClinicState();
}

class _UIToAddClinicState extends State<UIToAddClinic> {
  Map<String, dynamic> getRequestBody(
      ClinicDetailsOfDoctor clinicDetailsOfDoctor) {
    Map<String, dynamic> requestBody = <String, dynamic>{};
    requestBody['clinicName'] = clinicDetailsOfDoctor.clinicName;
    requestBody['country'] = clinicDetailsOfDoctor.country;
    requestBody['state'] = clinicDetailsOfDoctor.state;
    requestBody['addressLine'] = clinicDetailsOfDoctor.addressLine;
    requestBody['googleMapLink'] = clinicDetailsOfDoctor.googleMapLink;
    requestBody['appointmentDuration'] =
        clinicDetailsOfDoctor.appointmentDuration;
    requestBody['normalAppointmentCharge'] =
        clinicDetailsOfDoctor.normalAppointmentCharge;
    requestBody['emergencyCharge'] = clinicDetailsOfDoctor.emergencyCharge;
    for (int i = 0; i < clinicDetailsOfDoctor.availableDays.length; i++) {
      for (int j = 0;
          j < clinicDetailsOfDoctor.availableDays[i].workingDays.length;
          j++) {
        requestBody['day[$i][$j]'] =
            clinicDetailsOfDoctor.availableDays[i].workingDays[j];
      }
      for (int k = 0;
          k < clinicDetailsOfDoctor.availableDays[i].availableTimeSlots.length;
          k++) {
        requestBody['start_time[$i][$k]'] = clinicDetailsOfDoctor
            .availableDays[i].availableTimeSlots[k].startTime;
        requestBody['end_time[$i][$k]'] = clinicDetailsOfDoctor
            .availableDays[i].availableTimeSlots[k].endTime;
      }
    }
    return requestBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add clinic")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...clinic1.availableDays
                .asMap()
                .map((i, element) => MapEntry(
                    i,
                    WorkingDaysAndShiftWidget(
                      day: element,
                      index: i,
                      onDelete: () {
                        setState(() {
                          clinic1.availableDays.removeAt(i);
                        });
                      },
                    )))
                .values
                .toList(),
            addWorkingDaysAndShiftsButton(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  TextButton saveButton() {
    return TextButton(
        onPressed: () {
          // log(clinic1.toJson().toString());
          log(getRequestBody(clinic1).toString());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Save"), Icon(Icons.save)],
        ));
  }

  TextButton addWorkingDaysAndShiftsButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            clinic1.availableDays.add(AvailableDay(
                workingDays: [],
                availableTimeSlots: [TimeSlot(startTime: "", endTime: "")]));
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Add Working Days and Shift"),
            const Icon(Icons.add)
          ],
        ));
  }
}
