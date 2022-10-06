import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:notes_keeper/controller/nav_controller.dart';
import 'package:notes_keeper/models/notes.dart';
import 'package:notes_keeper/views/screens/home_screen.dart';

import 'package:path_provider/path_provider.dart' as path;

import 'database/sqlite/dp_helper.dart';
import 'views/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesAdapter());
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes Keeper',
      theme: ThemeData(
        textTheme: GoogleFonts.varelaRoundTextTheme(),
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreen(),
    );
  }
}
