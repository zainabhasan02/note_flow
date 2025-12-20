import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import 'package:noteflow/core/routes/app_routes.dart';
import 'package:noteflow/core/routes/routes_name.dart';
import 'package:noteflow/data/models/note_model.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: AppStrings.appName,
      initialRoute: RoutesName.splashScreen,
      getPages: AppRoutes.appRoutes(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _noteController = TextEditingController();
  final Box<NoteModel> _notesBox = Hive.box<NoteModel>('notes');

  void showNoteDialog([NoteModel? noteModel]) {
    if (noteModel != null) {
      _noteController.text = noteModel.content;
    } else {
      _noteController.clear();
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              noteModel == null ? AppStrings.createNote : AppStrings.editNote,
            ),
            content: TextField(
              controller: _noteController,
              decoration: InputDecoration(hintText: AppStrings.enterNoteHint),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(AppStrings.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final content = _noteController.text.trim();
                  if (content.isNotEmpty) {
                    if (noteModel == null) {
                      // Create
                      final newNote = NoteModel(
                        id: const Uuid().v4(),
                        //id: DateTime.now().millisecondsSinceEpoch.toString(),
                        content: content,
                        createdAt: DateTime.now(),
                      );
                      _notesBox.add(newNote);
                    } else {
                      // Update
                      noteModel.content = content;
                      noteModel.save();
                    }
                    Get.back();
                    _noteController.clear();
                  }
                },
                child: Text(
                  noteModel == null ? AppStrings.save : AppStrings.update,
                ),
              ),
            ],
          ),
    );
  }

  void deleteNote(NoteModel noteModel) {
    _notesBox.delete(noteModel.key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppStrings.appName),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: _notesBox.listenable(),
        builder: (context, Box<NoteModel> notesBox, _) {
          final notes = notesBox.values.toList();
          if (notes.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.noNotesFound,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final noteIndex = notes[index];
              return Dismissible(
                key: Key(noteIndex.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => deleteNote(noteIndex),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  child: ListTile(
                    title: Text(noteIndex.content),
                    leading: Text(
                      'Created: ${noteIndex.createdAt.toString().substring(0, 16)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showNoteDialog(noteIndex),
                    ),
                    onTap: () => showNoteDialog(noteIndex),
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
  }
}
