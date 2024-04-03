import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/ControllerTodo.dart';

class NotesScreen extends StatefulWidget {
  String title;

  NotesScreen({super.key, required this.title});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TodoController todoController = Get.find<TodoController>();
  final TextEditingController notes = TextEditingController();

  late int index;
  @override
  void initState() {
    super.initState();
    setState(() {
      index = todoController.listOfNotes.indexWhere((val) => val.title==widget.title);
      notes.text = todoController.listOfNotes[index].notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          todoController.addNote(
                              index, widget.title, notes.text);
                          Get.back();
                        },
                        child: const Icon(Icons.check, size: 35),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.85,
                    width: Get.width,
                    child: TextFormField(
                      autofocus: true,
                      controller: notes,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText: 'Start typing...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
