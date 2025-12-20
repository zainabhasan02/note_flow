import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteflow/core/constants/app_colors.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import 'package:noteflow/data/boxes/boxes.dart';
import 'package:noteflow/data/models/note_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  //final Box<NoteModel> _notesBox = Hive.box<NoteModel>('notes');
  final _notesBox = Boxes.getNotes();

  void showNoteDialog([NoteModel? noteModel]) {
    if (noteModel != null) {
      _titleController.text = noteModel.title;
      _descController.text = noteModel.description;
    } else {
      _titleController.clear();
      _descController.clear();
    }
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              noteModel == null ? AppStrings.createNote : AppStrings.editNote,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: AppStrings.enterTitleHint,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _descController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: AppStrings.enterDescHint,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(AppStrings.cancel),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surfaceTint,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  final data = NoteModel(
                    title: _titleController.text,
                    description: _descController.text,
                    createdAt: DateTime.now(),
                  );

                  final box = Boxes.getNotes();
                  if (noteModel == null) {
                    // Create
                    box.add(data);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Note Added successfully..')),
                    );
                  } else {
                    // Update
                    noteModel.title = _titleController.text;
                    noteModel.description = _descController.text;
                    noteModel.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Note Updated')),
                    );
                  }

                  Get.back();
                  //_titleController.clear();
                  //_descController.clear();
                },
                child: Text(
                  noteModel == null ? AppStrings.save : AppStrings.update,
                ),
              ),
            ],
          ),
    );
  }

  void deleteNote(NoteModel noteModel) async {
    //_notesBox.delete(noteModel.key);
    await noteModel.delete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppStrings.appName),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<NoteModel>>(
          valueListenable: _notesBox.listenable(),
          builder: (context, box, _) {
            var data = box.values.toList();
            if (data.isEmpty) {
              return const Center(
                child: Text(
                  AppStrings.noNotesFound,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(data[index].toString()),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Confirm Deletion'),
                            content: const Text(
                              'Are you sure you want to delete this note?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  deleteNote(data[index]);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Note deleted')),
                                  );
                                  Get.back();
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                    );
                  },
                  //onDismissed: (_) => deleteNote(data[index]),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    child: ListTile(
                      onLongPress: () {
                        print('Created At: ${data[index].createdAt}');
                        Text(
                          'Created: ${data[index].createdAt.toString().substring(0, 16)}',
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                      title: Text(
                        data[index].title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.babyBlue,
                        ),
                        child: Center(
                          child: Text(
                            data[index].title[0],
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      subtitle: Text(
                        data[index].description,
                        style: TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => showNoteDialog(data[index]),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showNoteDialog(),
          tooltip: AppStrings.createNote,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }
}
