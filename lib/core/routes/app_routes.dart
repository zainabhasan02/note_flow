import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:noteflow/core/routes/routes_name.dart';
import 'package:noteflow/main.dart';
import 'package:noteflow/views/notes/notes_screen.dart';
import 'package:noteflow/views/splash/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(name: RoutesName.splashScreen, page: () => SplashScreen()),
    GetPage(name: RoutesName.myHomePage, page: () => MyHomePage()),
    GetPage(name: RoutesName.notesScreen, page: () => NotesScreen()),
  ];
}
