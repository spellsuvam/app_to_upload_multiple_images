// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:camera_app/heallivedoctormodeltest/clinicdetailsofdoctor.dart';

class DoctorDetails {
  String name;
  List<ClinicDetailsOfDoctor> clinics;
  DoctorDetails({
    required this.name,
    required this.clinics,
  });

  DoctorDetails copyWith({
    String? name,
    List<ClinicDetailsOfDoctor>? clinics,
  }) {
    return DoctorDetails(
      name: name ?? this.name,
      clinics: clinics ?? this.clinics,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'clinics': clinics.map((x) => x.toMap()).toList(),
    };
  }

  factory DoctorDetails.fromMap(Map<String, dynamic> map) {
    return DoctorDetails(
      name: map['name'] as String,
      clinics: List<ClinicDetailsOfDoctor>.from(
        (map['clinics'] as List<int>).map<ClinicDetailsOfDoctor>(
          (x) => ClinicDetailsOfDoctor.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorDetails.fromJson(String source) =>
      DoctorDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DoctorDetails(name: $name, clinics: $clinics)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DoctorDetails &&
        other.name == name &&
        listEquals(other.clinics, clinics);
  }

  @override
  int get hashCode => name.hashCode ^ clinics.hashCode;
}
