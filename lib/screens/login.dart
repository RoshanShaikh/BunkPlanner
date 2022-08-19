import 'dart:math';
import 'package:bunk_planner/global_data.dart';
import 'package:bunk_planner/models/app_user.dart';
import 'package:bunk_planner/services/sign_in.dart';
import 'package:bunk_planner/widgets/background.dart';
import 'package:bunk_planner/widgets/circular_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<void> login(BuildContext context,
      {required VoidCallback userExist,
      required VoidCallback userNotExist}) async {
    EasyLoading.show(status: "Signing In", dismissOnTap: false);
    try {
      await signInWithGoogle().then((value) => null);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        EasyLoading.showSuccess('Ready to Bunk!');
        await initGlobalData();
        if (appUser == null) {
          appUser = AppUser(userId: user.uid, email: user.email);
          userNotExist.call();
        } else {
          userExist.call();
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      EasyLoading.showError('Oops!\nSomething Went Wrong');
    }
    EasyLoading.dismiss(animation: true);
  }

  @override
  Widget build(BuildContext context) {
    signOut();
    appUser = null;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: GoogleFonts.dancingScript(
                  fontSize: min(size.height * 0.04, 40),
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Login To Start Bunking',
                style: GoogleFonts.lobster(
                  fontSize: min(35, size.height * 0.035),
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              CircularButton(
                onPressed: () => login(
                  context,
                  userExist: () {
                    Navigator.pushReplacementNamed(context, 'homePage');
                  },
                  userNotExist: () {
                    Navigator.pushReplacementNamed(context, 'courseForm');
                  },
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/google_logo.png',
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Login With Google",
                      style: GoogleFonts.heebo(
                        fontSize: 20,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
