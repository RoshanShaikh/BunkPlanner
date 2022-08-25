import 'package:bunk_planner/widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class ListTemplate extends StatefulWidget {
  final List<String> list;
  final GlobalKey<FormState> formKey;
  const ListTemplate({
    Key? key,
    required this.list,
    required this.formKey,
  }) : super(key: key);

  @override
  State<ListTemplate> createState() => _ListTemplateState();
}

class _ListTemplateState extends State<ListTemplate> {
  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      widget.list.add('');
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromRGBO(50, 75, 205, 1),
              child: IconButton(
                onPressed: () {
                  if (widget.list.length < 5) {
                    setState(() {
                      widget.list
                          .removeWhere((element) => element.trim().isEmpty);
                      widget.list.add('');
                    });
                  }
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                splashRadius: 25,
              ),
            ),
          ),
          Form(
            key: widget.formKey,
            child: ListView.builder(
              key: UniqueKey(),
              shrinkWrap: true,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    onChanged: (text) {
                      widget.list[index] = text.trim();
                    },
                    validator: (value) {
                      value = value?.trim();
                      final list = [];

                      widget.list.forEach((element) {
                        if (element.isNotEmpty) list.add(element);
                      });

                      if (list.isEmpty && (value == null || value.isEmpty)) {
                        return 'Enter At least One Faculty';
                      }
                    },
                    textCapitalization: TextCapitalization.words,
                    initialValue: widget.list[index],
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          widget.list.removeAt(index);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Color.fromRGBO(50, 75, 205, 1),
                          size: 20,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.person_sharp,
                        size: 30,
                        color: Color.fromRGBO(50, 75, 205, 1),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
