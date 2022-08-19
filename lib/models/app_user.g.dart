// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      userId: json['userId'] as String?,
      course: json['course'] as String?,
      sem: json['sem'] as int?,
    )..email = json['email'] as String?;

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'userId': instance.userId,
      'course': instance.course,
      'email': instance.email,
      'sem': instance.sem,
    };
