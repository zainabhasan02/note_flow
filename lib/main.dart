import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import 'package:noteflow/core/routes/app_routes.dart';
import 'package:noteflow/core/routes/routes_name.dart';
import 'package:noteflow/core/widgets/nav_drawer/nav_drawer_widget.dart';
import 'package:noteflow/data/models/note_model.dart';
import 'package:noteflow/views/home/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
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
      /*theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),*/
      //home: MainScreen(),
    );
  }
}

/*class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [NavDrawerWidget(), HomeScreen()]));
  }
}*/
