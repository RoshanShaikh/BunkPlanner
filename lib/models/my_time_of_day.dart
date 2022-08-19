import 'package:flutter/material.dart';

class MyTimeOfDay extends TimeOfDay {
  const MyTimeOfDay({required super.hour, required super.minute});

  factory MyTimeOfDay.fromJson(Map<String, dynamic> json) {
    return MyTimeOfDay(hour: json['hour'], minute: json['minute']);
  }

  static double interval(MyTimeOfDay t1, MyTimeOfDay t2) {
    int hourDiff = (t1.hour - t2.hour);
    int minuteDiff = (t1.minute - t2.minute);

    double diff = hourDiff + (minuteDiff / 60);

    return diff.abs();
  }

  Map<String, dynamic> toJson() {
    return {
      "hour": hour,
      "minute": minute,
    };
  }

  @override
  String toString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
