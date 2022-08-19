import 'package:bunk_planner/global_data.dart';
import 'package:bunk_planner/services/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    String? photoUrl = user?.photoURL;

    return Drawer(
      child: Material(
        color: const Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            UserAccountsDrawerHeader(
              accountName: Text(
                '${user?.displayName}',
                style: GoogleFonts.lobster(letterSpacing: 2, fontSize: 20),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(
                    'assets/images/bg.jpg',
                  ),
                ),
              ),
              accountEmail: Text(
                "${user?.email}",
                style: GoogleFonts.heebo(fontSize: 15),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: photoUrl == null
                    ? Text(
                        user!.displayName![0],
                        style: GoogleFonts.oleoScriptSwashCaps(fontSize: 45.0),
                      )
                    : Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.network(
                          photoUrl,
                          width: 100,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            menuItem(
              text: 'Subjects',
              icon: Icons.menu_book,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            menuItem(
              text: 'Timetable',
              icon: Icons.calendar_month,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            menuItem(
              text: 'Attendance',
              icon: FontAwesome.calendar_check_o,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            menuItem(
              text: 'Logout',
              icon: Icons.logout,
              onTap: () async {
                try {
                  printData();
                } catch (e) {}
                await signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'loginScreen', (route) => false));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(
      {required String text, required IconData icon, void Function()? onTap}) {
    const color = Colors.white;
    // Color.fromRGBO(50, 75, 205, 1);

    return ListTile(
      title: Text(
        text,
        style: GoogleFonts.heebo(
          color: color,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
      leading: Icon(
        icon,
        color: color,
      ),
    );
  }
}
