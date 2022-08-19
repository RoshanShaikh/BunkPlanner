// ignore_for_file: dead_code

import 'dart:developer';
import 'package:bunk_planner/global_data.dart';
import 'package:bunk_planner/services/sign_in.dart';
import 'package:bunk_planner/widgets/background.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'LOGIN',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () async {
                  await signInWithGoogle();
                  await initGlobalData();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 119, 0),
                        Color.fromARGB(255, 255, 195, 90)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    'LOGIN WITH GOOGLE',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  signOut();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 119, 0),
                        Color.fromARGB(255, 255, 195, 90)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    'LOG OUT',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  process();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 119, 0),
                        Color.fromARGB(255, 255, 195, 90)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    'Process',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

process() async {
  final attendanceList = await dbService?.getAttendance(
      userId: appUser!.userId!,
      termId: 'IT - 7',
      toDate: DateTime(2022, 8, 12));

  if (attendanceList != null) {
    for (var attDay in attendanceList) {
      final dayTT = timetable?[attDay['day']];
      log('''
Date : ${attDay['date']}
Day : ${attDay['day']}
''');
      attDay['attendance'].forEach((lec, att) {
        log('\t\t${dayTT?[lec]} : $att');
      });
    }
  }
  return;
  // final userData = await dbService?.getUserData(appUser!.userId!);
  final termData = await dbService?.getTermsData(appUser!.userId!, 'IT - 7');

  timetable = termData?['timetable'];

  subjects = termData?['subjects'];

  printData();
}
