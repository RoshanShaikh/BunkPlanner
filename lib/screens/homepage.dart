import 'package:bunk_planner/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(50, 75, 205, 1),
        title: Text('HomePage'),
      ),
    );
  }
}
