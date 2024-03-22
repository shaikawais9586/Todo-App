import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ControllerTodo.dart';
import 'NotesScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double height = Get.height;
  double width = Get.width;

  bool clickedOnEdit=false;

  final todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.49,
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'TODO',
                          style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.49,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(12)),
                            child: Icon(
                              Icons.add,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            dialogAlert();
                          },
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              return Container(
                height: height * 0.75,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Colors.white),
                child: ListView.builder(
                  itemCount: todoController.tasksList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          var data = todoController.tasksList[index];
                          print(data);
                          Get.to(NotesScreen(title: data));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              todoController.tasksList[index],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text(
                                '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'),
                            trailing: SizedBox(
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      clickedOnEdit=true;
                                      dialogAlert();
                                      todoController.editTask(
                                          todoController.tasksList.indexOf(
                                              todoController.tasksList[index]));
                                    },
                                    child: Icon(
                                      Icons.edit_note,
                                      size: 32,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      todoController.deleteTask(
                                          todoController.tasksList[index]);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 32,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Future dialogAlert() {
    return Get.defaultDialog(
        title: 'Task',
        titlePadding: EdgeInsets.only(top: 20),
        content: TextFormField(
          controller: todoController.taskName,
          decoration: InputDecoration(
              labelText: 'Enter Task Name', suffixIcon: Icon(Icons.task)),
        ),
        contentPadding: EdgeInsets.only(top: 10, left: 15, right: 15),
        confirm: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
              onPressed: () {
                if(clickedOnEdit){
                  todoController.editTask(todoController.tasksList
                      .indexOf(todoController.taskName));
                  print(todoController.tasksList
                      .indexOf(todoController.taskName));
                  clickedOnEdit=false;
                }else{
                  todoController.addTask();
                }
                Get.back();
              },
              child: Text('Add')),
        ),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
              onPressed: () {
                todoController.taskName.clear();
                Get.back();
              },
              child: Text('Cancel')),
        ),
        backgroundColor: Colors.grey.shade300);
  }
}
