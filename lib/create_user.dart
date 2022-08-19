// import 'dart:convert';
// import 'package:bunk_planner/global_data.dart';
// import 'package:bunk_planner/models/app_user.dart';
// import 'package:bunk_planner/models/lecture.dart';
// import 'package:bunk_planner/models/my_time_of_day.dart';
// import 'package:bunk_planner/models/weekday.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// AppUser createUser(String id) {
//   AppUser appUser = AppUser.fromUserId(id);
//   appUser.course = "CE";
//   appUser.sem = 5;

//   appUser.addFaculties("KS", ["NPD", "DCV"]);
//   appUser.addFaculties("DC", ["VD", "SRS"]);
//   appUser.addFaculties("WT", ["MMG", "ANV"]);

//   Lecture lec1 = Lecture(
//       startTime: const MyTimeOfDay(hour: 10, minute: 30),
//       endTime: const MyTimeOfDay(hour: 11, minute: 30),
//       subjectName: "KS",
//       facultyName: "NPD");

//   Lecture lec2 = Lecture(
//       startTime: const MyTimeOfDay(hour: 11, minute: 30),
//       endTime: const MyTimeOfDay(hour: 12, minute: 30),
//       subjectName: "DC",
//       facultyName: "SRS");

//   Lecture lec3 = Lecture(
//       startTime: const MyTimeOfDay(hour: 13, minute: 30),
//       endTime: const MyTimeOfDay(hour: 14, minute: 30),
//       subjectName: "WT",
//       facultyName: "MMG");

//   appUser.timetable.putIfAbsent(Weekday.saturday, () => [lec1, lec2, lec3]);

//   lec1 = Lecture(
//       startTime: const MyTimeOfDay(hour: 10, minute: 30),
//       endTime: const MyTimeOfDay(hour: 11, minute: 30),
//       subjectName: "KS",
//       facultyName: "DCV");

//   lec2 = Lecture(
//       startTime: const MyTimeOfDay(hour: 11, minute: 30),
//       endTime: const MyTimeOfDay(hour: 12, minute: 30),
//       subjectName: "DC",
//       facultyName: "VD");

//   lec3 = Lecture(
//       startTime: const MyTimeOfDay(hour: 13, minute: 30),
//       endTime: const MyTimeOfDay(hour: 14, minute: 30),
//       subjectName: "WT",
//       facultyName: "ANV");

//   appUser.timetable.putIfAbsent(Weekday.monday, () => [lec1, lec2, lec3]);

//   return appUser;
// }

// Future<AppUser?> getUserData(String id) async {
//   final ref = FirebaseFirestore.instance.collection('users').doc(id);

//   final data = await ref.get();
//   final map = data.data();

//   if (map != null) return AppUser.fromJson(map);
//   return null;
// }

// Future<void> storeUser(AppUser user) async {
//   final docSubs = FirebaseFirestore.instance.collection('subjects').doc();

//   await docSubs.set(user.subjects);

//   final docTimetable =
//       FirebaseFirestore.instance.collection('timetables').doc();

//   final timetable = user.timetable;

//   Map<String, List<Map<String, dynamic>>> timetableJson = {};

//   timetable.forEach((key, value) {
//     timetableJson.putIfAbsent(key.toString(), () => []);
//     for (var element in value) {
//       timetableJson[key]?.add(element.toJson());
//     }
//   });

//   docTimetable.set(timetableJson);

//   final docUser =
//       FirebaseFirestore.instance.collection('users').doc(user.userId);

//   await docUser.set({
//     'id': user.userId,
//     'branch': user.course,
//     'sem': user.sem,
//     'subjects': docSubs.id,
//     'timetable': docTimetable.id,
//   });

//   // await docUser.set(user.toJson());
// }

// Future<Map<String, dynamic>?> getUser(String id) async {
//   final docUser = FirebaseFirestore.instance.collection('users').doc(id);

//   final snapshot = await docUser.get();

//   final data = snapshot.data();

//   print(jsonEncode(data));

//   return data;
// }

// Future<Map<String, dynamic>?> getSubjects(String id) async {
//   final docSubjects = FirebaseFirestore.instance.collection('subjects').doc(id);

//   final snapshot = await docSubjects.get();

//   final data = snapshot.data();

//   print(jsonEncode(data));

//   return data;
// }

// Future<Map<String, dynamic>?> getTimeTable(String id) async {
//   final docTimetable =
//       FirebaseFirestore.instance.collection('timetables').doc(id);

//   final snapshot = await docTimetable.get();

//   final data = snapshot.data();

//   print(jsonEncode(data));

//   return data;
// }

// Future<void> doWork(String email) async {
//   // final user = await getUserData(email);
//   // final terms =
//   //     await dbService?.getTermsData("${appUser!.course} - ${appUser!.sem}");
//   // print("_____________________________");
//   // print("${user.runtimeType}\n");
//   // print(user);
//   // print("_____________________________");
//   // print("${terms.runtimeType}\n");
//   // print(terms);
// }
