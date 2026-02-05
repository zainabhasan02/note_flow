import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import 'package:noteflow/core/routes/app_routes.dart';
import 'package:noteflow/core/routes/routes_name.dart';
import 'package:noteflow/data/models/note_model.dart';
import 'package:noteflow/views/bmi/bmi_screen.dart';
import 'package:noteflow/views/notes/notes_screen2.dart';
import 'package:path_provider/path_provider.dart';

import 'controllers/nav_drawer_controller/nav_controller.dart';
import 'core/widgets/app_bar/custom_app_bar_widget.dart';
import 'core/widgets/nav_drawer/nav_drawer_widget.dart';
import 'views/home/home_screen.dart';

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
      title: AppStrings.appName,
      initialRoute: RoutesName.splashScreen,
      getPages: AppRoutes.appRoutes(),
      /*theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),*/
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  //String currentRoute = RoutesName.homeScreen;
  final NavController navController = Get.put(NavController());

  final double xOffset = 230;

  final double yOffset = 150;

  final double scaleFactor = 0.85;

  Widget getScreen(String route) {
    switch (route) {
      case RoutesName.notesScreen2:
        return const NotesScreen2();
      case RoutesName.bmiScreen:
        return const BmiScreen();
      default:
        return const HomeScreen();
    }
  }

  /*void navigateTo(String _route) {
    setState(() => route = _route);
    Navigator.pop(context); // close drawer
  }*/
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isOpen = navController.isDrawerOpen.value;

      return Stack(
        children: [
          NavDrawerWidget(onItemTap: navController.changeRoute),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            transform: Matrix4.translationValues(
              isOpen ? xOffset : 0,
              isOpen ? yOffset : 0,
              0,
            )..scale( isOpen ? scaleFactor : 1.0,
              isOpen ? scaleFactor : 1.0,),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isOpen ? 40 : 0),
            ),
            child: Scaffold(
              appBar: CustomAppBarWidget(
                screenTitle: 'Note Flow',
                isDrawerOpen: isOpen,
                onMenuTap: () => navController.openDrawer(),
                onBackTap: () => navController.closeDrawer(),
              ),
              body: getScreen(navController.currentRoute.value),
            ),
          ),
        ],
      );
    });
  }
}
