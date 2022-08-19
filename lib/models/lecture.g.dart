// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lecture _$LectureFromJson(Map<String, dynamic> json) => Lecture(
      startTime:
          MyTimeOfDay.fromJson(json['startTime'] as Map<String, dynamic>),
      endTime: MyTimeOfDay.fromJson(json['endTime'] as Map<String, dynamic>),
      subjectName: json['subjectName'] as String,
      facultyName: json['facultyName'] as String,
      hours: json['hours'] as int,
    );

Map<String, dynamic> _$LectureToJson(Lecture instance) => <String, dynamic>{
      'startTime': instance.startTime.toJson(),
      'endTime': instance.endTime.toJson(),
      'subjectName': instance.subjectName,
      'facultyName': instance.facultyName,
      'hours': instance.hours,
    };
