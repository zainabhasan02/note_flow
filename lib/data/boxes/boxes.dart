import 'package:hive/hive.dart';
import 'package:noteflow/data/models/note_model.dart';

class Boxes {
  static Box<NoteModel> getNotes() => Hive.box<NoteModel>('notes');
}
