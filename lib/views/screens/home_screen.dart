import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes_keeper/controller/notes_controller.dart';
import 'package:notes_keeper/models/notes.dart';
import 'package:notes_keeper/utils/color_resource.dart';

import '../../controller/nav_controller.dart';
import '../widgets/notes_card.dart';
import '../widgets/top_greeting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final navController = Get.find<NavController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<NotesController>(
            init: NotesController(),
            builder: (value) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const TopGreetingWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: ColorsRes.skyColor.withOpacity(.2),
                        border: Border.all(
                          color: ColorsRes.skyColor.withOpacity(.3),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Search Notes",
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
                      height: 10,
                    ),
                    const Text(
                      "All Notes",
                      style: TextStyle(
                          color: ColorsRes.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 90,
                      color: ColorsRes.skyColor,
                      height: 3,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: MasonryGridView.count(
                        itemCount: value.listNotes.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () {
                              value.deleteNotes(index);
                              Get.snackbar("Sucess", "Notes Deleted");
                              value.getNotes();
                            },
                            onTap: () {
                              navController.pageUpdate(1);
                              navController.addNoteForEdit(
                                Notes(
                                    title: value.listNotes[index].title,
                                    description:
                                        value.listNotes[index].description,
                                    color: value.listNotes[index].color,
                                    date: value.listNotes[index].date),
                                index,
                                true,
                              );
                            },
                            child: NotesCard(
                              notes: value.listNotes[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[800],
    ),
  );
}
