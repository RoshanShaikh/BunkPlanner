import 'dart:math';
import 'package:bunk_planner/global_data.dart';
import 'package:bunk_planner/widgets/background.dart';
import 'package:bunk_planner/widgets/circular_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseForm extends StatelessWidget {
  CourseForm({Key? key}) : super(key: key);

  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _semController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? name = FirebaseAuth.instance.currentUser?.displayName;
    name = (name == null) ? "" : name.split(" ")[0];
    return Scaffold(
      body: Background(
        child: Container(
          // alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hey! $name',
                style: GoogleFonts.dancingScript(
                  fontSize: min(size.height * 0.04, 40),
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(
                  // height: 5,
                  ),
              Text(
                'Provide Us Your Details',
                style: GoogleFonts.pacifico(
                  fontSize: min(35, size.height * 0.035),
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't Be Empty";
                        }
                      },
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      controller: _courseController,
                      decoration: const InputDecoration(
                        labelText: 'Course',
                        icon: Icon(
                          Icons.school,
                          size: 30,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't Be Empty";
                        }
                        if (int.parse(value) > 9) {
                          return "Max semester is 9";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _semController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Sem / Year',
                        icon: Icon(
                          Icons.history_edu,
                          size: 30,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CircularButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    appUser?.course = _courseController.text.trim();
                    appUser?.sem = int.parse(_semController.text.trim());
                    await dbService
                        ?.setUserData(
                          appUser!.userId!,
                          appUser!.toJson(),
                        )
                        .then((value) => Navigator.pushNamedAndRemoveUntil(
                            context, 'homePage', (route) => false));
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_forward_sharp),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Continue",
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
