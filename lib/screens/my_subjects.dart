import 'package:bunk_planner/global_data.dart';
import 'package:bunk_planner/screens/subject_form.dart';
import 'package:flutter/material.dart';

class MySubjectsPage extends StatefulWidget {
  const MySubjectsPage({Key? key}) : super(key: key);

  @override
  State<MySubjectsPage> createState() => _MySubjectsPageState();
}

class _MySubjectsPageState extends State<MySubjectsPage> {
  @override
  Widget build(BuildContext context) {
    final keys = subjects?.keys.toList();
    keys?.sort();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Subjects',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(50, 75, 205, 1),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SubjectForm(
                enabled: true,
              );
            },
          ));
          setState(() {});
        },
      ),
      body: ListView.builder(
        itemCount: subjects != null ? subjects!.length : 0,
        itemBuilder: (BuildContext context, index) {
          final key = keys!.elementAt(index);
          final faculties = subjects![key];
          return Card(
            elevation: 2,
            child: ListTile(
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SubjectForm(
                      index: index,
                    );
                  },
                ));
                setState(() {});
              },
              title: Row(
                children: [
                  Text(
                    keys.elementAt(index),
                  ),
                ],
              ),
              subtitle: ListView.builder(
                shrinkWrap: true, // 1st add
                physics: const ClampingScrollPhysics(),
                itemCount: faculties != null ? faculties.length : 0, //
                itemBuilder: (context, facIdx) {
                  return Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${faculties?[facIdx]}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
