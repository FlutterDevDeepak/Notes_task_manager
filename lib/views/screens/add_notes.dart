import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_keeper/controller/nav_controller.dart';
import 'package:notes_keeper/controller/notes_controller.dart';
import 'package:notes_keeper/models/notes.dart';
import 'package:notes_keeper/utils/color_resource.dart';
import 'package:notes_keeper/views/screens/home_screen.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({Key? key}) : super(key: key);

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  int _selectedColor = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final DateTime _date = DateTime.now();
  final DateFormat dateFormat = DateFormat("dd MMM yyyy");
  final navController = Get.find<NavController>();
  NotesController notedController = Get.put(NotesController());

  @override
  void initState() {
    super.initState();
    editNotes();
  }

  editNotes() {
    if (notedController.listNotes.isEmpty) {
      navController.isEdit = false;
    } else if (navController.isEdit == true) {
      titleController.text = navController.notes!.title;
      descriptionController.text = navController.notes!.description;
      _selectedColor = navController.notes!.color;
    } else {
      titleController.text = "";
      descriptionController.text = "";
      _selectedColor = 0;
    }
  }

  @override
  void dispose() {
    titleController.clear();
    descriptionController.clear();
    _selectedColor = 0;
    navController.isEdit = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(
        init: NotesController(),
        builder: (value) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsRes.whiteColor,
              elevation: 0,
              title: const Text("Add Notes"),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: ColorsRes.grayColor.withOpacity(.2),
                      border: Border.all(
                        color: ColorsRes.skyColor.withOpacity(.3),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      autocorrect: false,
                      controller: titleController,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.search),
                        hintText: "Enter Notes Title",
                        hintStyle: subTitleStyle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: ColorsRes.grayColor.withOpacity(.2),
                      border: Border.all(
                        color: ColorsRes.skyColor.withOpacity(.3),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      autocorrect: false,
                      controller: descriptionController,
                      maxLines: 8,
                      // minLines: 4,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.search),
                        hintText: "Enter Notes Description",
                        hintStyle: subTitleStyle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: List.generate(
                      3,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = index;
                              //print(_selectedColor);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: index == 0
                                  ? ColorsRes.skyColor
                                  : index == 1
                                      ? ColorsRes.lightOrangeColor
                                      : ColorsRes.lightPinkColor,
                              child: _selectedColor == index
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : Container(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isEmpty) {
                          Get.snackbar("Warning", "Please Enter Title");
                        } else if (descriptionController.text.isEmpty) {
                          Get.snackbar("Warning", "Please Enter Description");
                        } else {
                          if (navController.isEdit == true) {
                            Notes note = Notes(
                                title: titleController.text.toString(),
                                description:
                                    descriptionController.text.toString(),
                                color: _selectedColor,
                                date: dateFormat.format(_date));
                            value.editNotes(navController.possition!, note);
                            Get.snackbar(
                                "Success", "Notes Updated Sucessfully");
                            value.getNotes();
                            navController.pageUpdate(0);
                            titleController.clear();
                            descriptionController.clear();
                          } else {
                            Notes note = Notes(
                                title: titleController.text.toString(),
                                description:
                                    descriptionController.text.toString(),
                                color: _selectedColor,
                                date: dateFormat.format(_date));
                            value.addNotes(note);
                            Get.snackbar("Success", "Notes Added Sucessfully");
                            value.getNotes();
                            navController.pageUpdate(0);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Add Note",
                          style: TextStyle(
                              color: ColorsRes.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
