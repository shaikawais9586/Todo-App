import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TodoController extends GetxController{

  final taskName=TextEditingController();
  RxList tasksList=[].obs;

  final notes=TextEditingController();
  Map<String,String> titleNotes={
    'title' : '',
    'notes' : ''
  };

  void addTask(){
    tasksList.add(taskName.text);
    taskName.clear();
  }

  void deleteTask(String value){
    tasksList.remove(value);
  }

  void editTask(int index){
    if (index >= 0 && index < tasksList.length) {
      tasksList[index] = taskName.text;
    }else{
      print('error');
    }
    taskName.clear();
  }

  void addNote(String title, String notes){
    titleNotes['title']=title;
    titleNotes['notes']=notes;
    
    
    print(titleNotes);
  }
}