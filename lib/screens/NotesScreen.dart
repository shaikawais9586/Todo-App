import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/ControllerTodo.dart';

class NotesScreen extends StatelessWidget {

  String title;

  NotesScreen({super.key,required this.title});

  final todoController=Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,style: TextStyle(
                        fontSize: 30,

                      ),),
                      InkWell(
                        onTap: () {
                          todoController.addNote(title,todoController.notes.text);
                          Get.back();
                        },
                          child: Icon(Icons.check,size: 35)
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.9,
                    width: Get.width,
                    child: TextField(
                      controller: todoController.notes,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        hintText: 'Start typing...',
                        border: InputBorder.none
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
