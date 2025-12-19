import 'package:hive/hive.dart';

part 'note_model.g.dart'; // Run: flutter pub run build_runner build

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime createdAt;

  NoteModel({required this.id, required this.content, required this.createdAt});
}