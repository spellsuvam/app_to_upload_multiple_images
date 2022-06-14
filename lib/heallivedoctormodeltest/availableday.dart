import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'timeslot.dart';

class AvailableDay {
  List<String> workingDays;
  List<TimeSlot> availableTimeSlots;
  AvailableDay({
    required this.workingDays,
    required this.availableTimeSlots,
  });

  AvailableDay copyWith({
    List<String>? workingDays,
    List<TimeSlot>? availableTimeSlots,
  }) {
    return AvailableDay(
      workingDays: workingDays ?? this.workingDays,
      availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workingDays': workingDays,
      'availableTimeSlots': availableTimeSlots.map((x) => x.toMap()).toList(),
    };
  }

  factory AvailableDay.fromMap(Map<String, dynamic> map) {
    return AvailableDay(
      workingDays: List<String>.from((map['workingDays'] as List<String>)),
      availableTimeSlots: List<TimeSlot>.from(
        (map['availableTimeSlots'] as List<int>).map<TimeSlot>(
          (x) => TimeSlot.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableDay.fromJson(String source) =>
      AvailableDay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AvailableDay(workingDays: $workingDays, availableTimeSlots: $availableTimeSlots)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AvailableDay &&
        listEquals(other.workingDays, workingDays) &&
        listEquals(other.availableTimeSlots, availableTimeSlots);
  }

  @override
  int get hashCode => workingDays.hashCode ^ availableTimeSlots.hashCode;
}
