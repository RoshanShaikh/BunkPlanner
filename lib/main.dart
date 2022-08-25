import 'package:bunk_planner/screens/formfield.dart';
import 'package:bunk_planner/screens/homepage.dart';
import 'package:bunk_planner/screens/login.dart';
import 'package:bunk_planner/screens/course_form.dart';
import 'package:bunk_planner/screens/my_subjects.dart';
import 'package:bunk_planner/screens/subject_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  configEasyLoading();
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..maskType = EasyLoadingMaskType.black
    ..indicatorSize = 50
    ..indicatorColor = const Color.fromRGBO(50, 75, 205, 1)
    ..backgroundColor = Colors.white
    ..radius = 5
    ..textStyle = GoogleFonts.heebo(fontSize: 20, color: Colors.grey[900])
    ..textColor = Colors.black;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Color.fromRGBO(50, 75, 205, 1),
        fontFamily: GoogleFonts.heebo().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'loginScreen',
      // initialRoute: 'userDataForm',
      // initialRoute: 'loginScreen',
      // home: CompleteForm(),
      routes: {
        'mySubjects': (context) => MySubjectsPage(),
        'homePage': (BuildContext context) => HomePage(),
        'formField': (BuildContext context) => const CompleteForm(),
        'loginScreen': (BuildContext context) => const LoginScreen(),
        'courseForm': (BuildContext context) => CourseForm(),
      },
      builder: EasyLoading.init(),
    );
  }
}
