import 'dart:convert';

class TimeSlot {
  String startTime;
  String endTime;
  TimeSlot({
    required this.startTime,
    required this.endTime,
  });

  TimeSlot copyWith({
    String? startTime,
    String? endTime,
  }) {
    return TimeSlot(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeSlot.fromJson(String source) =>
      TimeSlot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TimeSlot(startTime: $startTime, endTime: $endTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeSlot &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}
