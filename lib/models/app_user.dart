import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser {
  String? userId;
  String? course;
  String? email;
  int? sem;

  AppUser({this.userId, this.course, this.sem, this.email});

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @override
  String toString() {
    return '''userId : $userId,course : $course,sem : $sem''';
  }
}
