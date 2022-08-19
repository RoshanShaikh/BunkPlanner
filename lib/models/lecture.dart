import 'package:bunk_planner/models/my_time_of_day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lecture.g.dart';

@JsonSerializable(explicitToJson: true)
class Lecture {
  MyTimeOfDay startTime;
  MyTimeOfDay endTime;
  String subjectName;
  String facultyName;
  int hours;

  Lecture(
      {required this.startTime,
      required this.endTime,
      required this.subjectName,
      required this.facultyName,
      required this.hours});

  factory Lecture.fromJson(Map<String, dynamic> json) =>
      _$LectureFromJson(json);

  Map<String, dynamic> toJson() => _$LectureToJson(this);

  @override
  String toString() {
    return '''$startTime - $endTime $facultyName | $subjectName''';
  }
}
