import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../model/Notes.dart';

class TodoController extends GetxController {
  late String taskName;

  RxList<Notes> listOfNotes = RxList.empty();

  void addTask(String task) {
    Notes note = Notes(title: task, notes: "");
    listOfNotes.add(note);
    // tasksList.add(task);
  }

  void deleteTask(int index) {
    listOfNotes.removeAt(index);
  }

  void editTask(int index, String task) {
    if (index >= 0 && index < listOfNotes.length) {
      listOfNotes[index].title = task;
      listOfNotes.refresh();
    } else {
      print('error');
    }
  }

  /// Notes Screen

  void addNote(int index, String title, String notes) {
    if (listOfNotes[index].title == title) {
      listOfNotes[index].notes = notes;
    }
  }
}