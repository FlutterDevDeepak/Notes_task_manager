import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notes_keeper/controller/nav_controller.dart';
import 'package:notes_keeper/utils/color_resource.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      init: NavController(),
      builder: (value) {
        return Scaffold(
          body: value.screen[value.page],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35), topLeft: Radius.circular(35)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0),
              ),
              child: BottomNavigationBar(
                elevation: 0.0,
                onTap: (i) {
                  value.pageUpdate(i);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.dashboard,
                        size: 30,
                        color: value.page == 0
                            ? ColorsRes.blackColor
                            : ColorsRes.grayColor,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: CircleAvatar(
                        // maxRadius: 22,
                        radius: 22,
                        backgroundColor: Colors.indigo[700],
                        child: const Icon(
                          Icons.add,
                          color: ColorsRes.whiteColor,
                          size: 30,
                        ),
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task,
                          color: value.page == 2
                              ? ColorsRes.blackColor
                              : ColorsRes.grayColor,
                          size: 30),
                      label: ""),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
