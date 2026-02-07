import 'package:get/get.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import '../../core/routes/routes_name.dart';

class NavController extends GetxController {
  var currentRoute = RoutesName.homeScreen.obs;
  var isDrawerOpen = false.obs;
  var currentTitle = 'Home'.obs;

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

  /// 🔥 ADD THIS METHOD
  void navigateTo(String route) {
    if (currentRoute.value == route) {
      closeDrawer();
      return;
    }

    currentRoute.value = route;
    currentTitle.value = _getTitle(route);
    closeDrawer();
  }

  /// 🔹 Route → Title mapping
  String _getTitle(String route) {
    switch (route) {
      case RoutesName.homeScreen:
        return AppStrings.home;
      case RoutesName.notesScreen2:
        return AppStrings.notes;
      case RoutesName.bmiScreen:
        return AppStrings.bmiCalculator;
      default:
        return AppStrings.appName;
    }
  }
}
