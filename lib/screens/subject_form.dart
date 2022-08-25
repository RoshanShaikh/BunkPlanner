import 'package:bunk_planner/global_data.dart';
import 'package:bunk_planner/widgets/circular_button.dart';
import 'package:bunk_planner/widgets/list_of_textfields.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class SubjectForm extends StatefulWidget {
  SubjectForm({Key? key, this.index, this.enabled = false}) : super(key: key);
  final int? index;
  bool enabled;

  @override
  State<SubjectForm> createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  String? title;
  final TextEditingController _subjectController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormState> facultiesFormKey = GlobalKey<FormState>();
  List<String> faculties = [];
  List<String> facultiesCopy = [];
  String? subjectName;
  List<String>? subjectNames;

  @override
  void initState() {
    super.initState();
    if (widget.index == null) {
      title = 'Add new Subject';
    } else {
      title = 'Edit Subject';
      if (widget.index != null) {
        subjectNames = subjects!.keys.toList()..sort();
        subjectName = subjectNames?.elementAt(widget.index!);
        _subjectController.text = subjectName!;
      }
      final nullableFaculties = subjects![subjectName];
      if (nullableFaculties != null) {
        faculties = nullableFaculties;
        facultiesCopy = faculties.toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.enabled);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.topCenter,
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              FontAwesome5.book,
                              // size: 28,
                              color: Color.fromRGBO(50, 75, 205, 1),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Subject Name',
                              style: TextStyle(
                                  color: Color.fromRGBO(50, 75, 205, 1),
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _subjectController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) {
                                return "Subject name can't be empty.";
                              }
                              int? i = subjectNames?.indexOf(value);
                              if (i != widget.index && i != -1) {
                                return "Subject with same name already exist.";
                              }

                              print("Subject valid");
                            },
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              enabled: widget.enabled,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                            splashRadius: 30,
                            icon: const Icon(
                              FontAwesome.pencil,
                              color: Color.fromRGBO(50, 75, 205, 1),
                            ),
                            onPressed: () {
                              setState(() {
                                widget.enabled = !widget.enabled;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              FontAwesome5.chalkboard_teacher,
                              // size: 28,
                              color: Color.fromRGBO(50, 75, 205, 1),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Faculties',
                              style: TextStyle(
                                  color: Color.fromRGBO(50, 75, 205, 1),
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTemplate(
                      list: facultiesCopy,
                      formKey: facultiesFormKey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.bottomCenter,
            child: CircularButton(
              splashColor: Colors.white12,
              color: const Color.fromRGBO(50, 75, 205, 1),
              onPressed: () {
                if (_key.currentState != null &&
                    _key.currentState!.validate() &&
                    facultiesFormKey.currentState != null &&
                    facultiesFormKey.currentState!.validate()) {
                  subjects?.remove(subjectName);
                  subjectName = _subjectController.text;

                  facultiesCopy.removeWhere((element) => element.isEmpty);
                  if (subjectName != null) {
                    subjects?.putIfAbsent(subjectName!, () => facultiesCopy);
                  }

                  if (appUser != null) {
                    final String userId = appUser!.userId!;
                    final String termId =
                        '${appUser!.course} - ${appUser!.sem}';
                    final tbMap = {};

                    timetable?.forEach((day, lectList) {
                      tbMap[day] = {};
                      lectList.forEach((lectNo, lecture) {
                        tbMap[day].putIfAbsent(lectNo, () => lecture.toJson());
                      });
                    });

                    final data = {
                      'subjects': subjects,
                      'timetable': tbMap,
                    };

                    dbService?.setTermData(userId, termId, data);
                  }

                  Navigator.pop(context);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.done_sharp,
                    size: 40,
                    color: Colors.white,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
