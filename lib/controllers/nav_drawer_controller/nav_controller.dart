import 'package:get/get.dart';
import '../../core/routes/routes_name.dart';

class NavController extends GetxController {
  var currentRoute = RoutesName.homeScreen.obs;
  var isDrawerOpen = false.obs;


  void changeRoute(String route) {
    currentRoute.value = route;
    isDrawerOpen.value = false; // close drawer
  }

  void openDrawer() {
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    isDrawerOpen.value = false;
  }
}
