import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notes_keeper/models/notes.dart';
import '../views/screens/add_notes.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/task_home_screen.dart';

class NavController extends GetxController {
  Notes? notes;
  int? possition;
  bool isEdit = false;

  addNoteForEdit(Notes data, int index, bool edit) {
    notes = data;
    possition = index;
    isEdit = edit;
    update();
  }

  List<Widget> screen = [
    const HomeScreen(),
    const AddNotesScreen(),
    const TaskHomeScreen(),
    // const Text("data"),
  ];
  int page = 0;

  pageUpdate(int index) {
    page = index;
    update();
  }
}
