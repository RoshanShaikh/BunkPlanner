import 'dart:collection';

import 'package:bunk_planner/models/app_user.dart';
import 'package:bunk_planner/models/lecture.dart';
import 'package:bunk_planner/models/weekday.dart';
import 'package:bunk_planner/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

AppUser? appUser;
FirebaseService? dbService;
Map<String, List<String>>? subjects;
Map<String, Map<String, Lecture>>? timetable;

initGlobalData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    dbService = FirebaseService();
    await initAppUser();
  }
}

initAppUser() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userData = await dbService?.getUserData(user.uid);
    if (userData != null) {
      appUser = AppUser.fromJson(userData);
      initTermData();
    }
  }
}

initTermData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final termsData = await dbService?.getTermsData(
        user.uid, '${appUser?.course} - ${appUser?.sem}');

    subjects = termsData?['subjects'];
    timetable = termsData?['timetable'];
  }
}

void printData() {
  log('AppUser : $appUser');
  log('Subjects : $subjects');
  log('Timetable : \n');
  final sorted = SplayTreeMap<String, dynamic>.from(
    timetable!,
    (day1, day2) {
      return Weekday.getIndex(day1).compareTo(Weekday.getIndex(day2));
    },
  );
  sorted.forEach((day, lectures) {
    log('\t$day : ');
    lectures.forEach((lecNo, lecture) {
      log('\t\t$lecNo : $lecture');
    });
  });
}
