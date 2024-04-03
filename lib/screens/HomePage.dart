import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ControllerTodo.dart';
import 'NotesScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double height = Get.height;
  double width = Get.width;

  final TextEditingController taskName = TextEditingController();

  bool clickedOnEdit = false;

  final TodoController todoController =
      Get.put<TodoController>(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "TODO",
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FloatingActionButton(
                      onPressed: () async {
                        await dialogAlert();
                      },
                      backgroundColor: Colors.red,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(() {
              return Container(
                height: height * 0.75,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: ListView.builder(
                  itemCount: todoController.listOfNotes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          var data = todoController.listOfNotes[index].title;
                          Get.to(
                            () => NotesScreen(title: data),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              todoController.listOfNotes[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text(
                              '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                            ),
                            trailing: SizedBox(
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      clickedOnEdit = true;
                                      todoController.taskName = todoController
                                          .listOfNotes[index].title;
                                      await dialogAlert();
                                      clickedOnEdit = false;
                                    },
                                    child: const Icon(
                                      Icons.edit_note,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      todoController.deleteTask(index);
                                      // todoController.deleteNotes(index);
                                    },
                                    child: const Icon(
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
        titlePadding: const EdgeInsets.only(top: 20),
        content: TextFormField(
          autofocus: true,
          controller: taskName,
          decoration: const InputDecoration(
            labelText: 'Enter Task Name',
            suffixIcon: Icon(Icons.task),
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        confirm: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
              onPressed: () {
                if (clickedOnEdit) {
                  print(todoController.listOfNotes.indexWhere(
                      (element) => element.title == todoController.taskName));
                  todoController.editTask(
                      todoController.listOfNotes.indexWhere(
                          (value) => value.title == todoController.taskName),
                      taskName.text);
                } else {
                  if (taskName.text.isNotEmpty) {
                    todoController.addTask(taskName.text);
                  }
                }
                taskName.clear();
                Get.back();
              },
              child: const Text('Add')),
        ),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
            onPressed: () {
              taskName.clear();
              Get.back();
            },
            child: const Text('Cancel'),
          ),
        ),
        backgroundColor: Colors.grey.shade300);
  }
}
