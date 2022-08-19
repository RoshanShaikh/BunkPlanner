import 'dart:developer';

import 'package:bunk_planner/models/lecture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  late final CollectionReference<Map<String, dynamic>> collectionUser;

  FirebaseService() {
    collectionUser = FirebaseFirestore.instance.collection('users');
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final snapshot = await collectionUser.doc(userId).get();
    final data = snapshot.data();
    return data;
  }

  Future<Map<String, dynamic>?> getTermsData(
      String userId, String termId) async {
    CollectionReference<Map<String, dynamic>> collectionTerms =
        collectionUser.doc(userId).collection('terms');
    final snapshot = await collectionTerms.doc(termId).get();
    final data = snapshot.data();
    if (data == null) return data;

    Map<String, List<String>> subjects = {};
    Map<String, dynamic> subjectsData = data['subjects'];
    subjectsData.forEach((key, value) {
      subjects[key] = [];
      value.forEach((e) => subjects[key]?.add(e.toString()));
    });

    Map<String, Map<String, Lecture>> timetable = {};
    Map<String, dynamic> timetableData = data['timetable'];
    timetableData.forEach((day, lectures) {
      timetable[day] = {};
      lectures.forEach((lecNo, lecture) =>
          timetable[day]?.putIfAbsent(lecNo, () => Lecture.fromJson(lecture)));
    });

    return {
      'subjects': subjects,
      'timetable': timetable,
    };
  }

  Future<List<Map<String, dynamic>>> getAttendance(
      {required String userId,
      required String termId,
      DateTime? fromDate,
      DateTime? toDate}) async {
    CollectionReference<Map<String, dynamic>> collectionAttendance =
        collectionUser
            .doc(userId)
            .collection('terms')
            .doc(termId)
            .collection('attendance');

    final attendanceData = await collectionAttendance
        .where('date', isGreaterThanOrEqualTo: fromDate)
        .where('date', isLessThanOrEqualTo: toDate)
        .get();

    List<Map<String, dynamic>> attendanceList = [];

    attendanceData.docs.forEach((element) {
      attendanceList.add(element.data());
    });

    List<Map<String, dynamic>> attendance = [];
    for (var element in attendanceList) {
      attendance.add(<String, dynamic>{
        'date': (element['date'] as Timestamp).toDate() as dynamic,
        'day': element['day'],
        'attendance': element['attendance'],
      });
    }

    return attendance;
  }

  Future<void> setUserData(String userId, Map<String, dynamic> data) async {
    await collectionUser.doc(userId).set(data);
  }

  Future<void> setTermData(
      String userId, String termId, Map<String, dynamic> data) async {
    CollectionReference<Map<String, dynamic>> collectionTerms =
        collectionUser.doc(userId).collection('terms');
    final docTerm = collectionTerms.doc(termId);

    await docTerm.set(data);
  }
}
