import 'package:hive/hive.dart';
part 'notes.g.dart';

@HiveType(typeId: 0)
class Notes {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final int color;

  Notes({required this.title, required this.description,required this.color,required this.date});
}
