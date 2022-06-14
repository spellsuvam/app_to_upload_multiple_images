// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'availableday.dart';

class ClinicDetailsOfDoctor {
  String clinicName;
  String country;
  String state;
  String addressLine;
  String? googleMapLink;
  String appointmentDuration;
  String normalAppointmentCharge;
  String emergencyCharge;
  List<AvailableDay> availableDays;
  ClinicDetailsOfDoctor({
    required this.clinicName,
    required this.country,
    required this.state,
    required this.addressLine,
    this.googleMapLink,
    required this.appointmentDuration,
    required this.normalAppointmentCharge,
    required this.emergencyCharge,
    required this.availableDays,
  });

  ClinicDetailsOfDoctor copyWith({
    String? clinicName,
    String? country,
    String? state,
    String? addressLine,
    String? googleMapLink,
    String? appointmentDuration,
    String? normalAppointmentCharge,
    String? emergencyCharge,
    List<AvailableDay>? availableDays,
  }) {
    return ClinicDetailsOfDoctor(
      clinicName: clinicName ?? this.clinicName,
      country: country ?? this.country,
      state: state ?? this.state,
      addressLine: addressLine ?? this.addressLine,
      googleMapLink: googleMapLink ?? this.googleMapLink,
      appointmentDuration: appointmentDuration ?? this.appointmentDuration,
      normalAppointmentCharge:
          normalAppointmentCharge ?? this.normalAppointmentCharge,
      emergencyCharge: emergencyCharge ?? this.emergencyCharge,
      availableDays: availableDays ?? this.availableDays,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clinicName': clinicName,
      'country': country,
      'state': state,
      'addressLine': addressLine,
      'googleMapLink': googleMapLink,
      'appointmentDuration': appointmentDuration,
      'normalAppointmentCharge': normalAppointmentCharge,
      'emergencyCharge': emergencyCharge,
      'availableDays': availableDays.map((x) => x.toMap()).toList(),
    };
  }

  factory ClinicDetailsOfDoctor.fromMap(Map<String, dynamic> map) {
    return ClinicDetailsOfDoctor(
      clinicName: map['clinicName'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
      addressLine: map['addressLine'] as String,
      googleMapLink:
          map['googleMapLink'] != null ? map['googleMapLink'] as String : null,
      appointmentDuration: map['appointmentDuration'] as String,
      normalAppointmentCharge: map['normalAppointmentCharge'] as String,
      emergencyCharge: map['emergencyCharge'] as String,
      availableDays: List<AvailableDay>.from(
        (map['availableDays'] as List<int>).map<AvailableDay>(
          (x) => AvailableDay.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicDetailsOfDoctor.fromJson(String source) =>
      ClinicDetailsOfDoctor.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClinicDetailsOfDoctor(clinicName: $clinicName, country: $country, state: $state, addressLine: $addressLine, googleMapLink: $googleMapLink, appointmentDuration: $appointmentDuration, normalAppointmentCharge: $normalAppointmentCharge, emergencyCharge: $emergencyCharge, availableDays: $availableDays)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClinicDetailsOfDoctor &&
        other.clinicName == clinicName &&
        other.country == country &&
        other.state == state &&
        other.addressLine == addressLine &&
        other.googleMapLink == googleMapLink &&
        other.appointmentDuration == appointmentDuration &&
        other.normalAppointmentCharge == normalAppointmentCharge &&
        other.emergencyCharge == emergencyCharge &&
        listEquals(other.availableDays, availableDays);
  }

  @override
  int get hashCode {
    return clinicName.hashCode ^
        country.hashCode ^
        state.hashCode ^
        addressLine.hashCode ^
        googleMapLink.hashCode ^
        appointmentDuration.hashCode ^
        normalAppointmentCharge.hashCode ^
        emergencyCharge.hashCode ^
        availableDays.hashCode;
  }
}
