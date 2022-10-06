import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notes_keeper/models/notes.dart';

class NotesController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getNotes();
  }

  List<Notes> listNotes = [];


  addNotes(Notes notes) async {
    var box = await Hive.openBox<Notes>('notes');
    box.add(notes);
    update();
  }

  Future getNotes() async {
    final box = await Hive.openBox<Notes>('notes');
    listNotes = box.values.toList();
    update();
  }

  deleteNotes(int position) async {
    final box = Hive.box<Notes>('notes');
    box.deleteAt(position);
    listNotes.removeAt(position);
    update();
  }

  editNotes(int position, Notes notes) async {
    var box = await Hive.openBox<Notes>('notes');
    box.putAt(position, notes);
    update();
  }
}
// functuion sab sahi h 