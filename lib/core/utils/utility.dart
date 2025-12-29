import 'package:get/get.dart';
import 'package:noteflow/core/routes/routes_name.dart';
import 'package:noteflow/core/services/shared_preference/app_preference.dart';

class Utility {
  static Future showConfirmDialog(title, message) async {
    return Get.defaultDialog(
      title: title,
      middleText: message,
      radius: 8,
      textCancel: 'Cancel',
      onCancel: () => Get.back(),
      onConfirm: () async {
        //Clear login data
        await AppPreference.clear();
        //Get.back();
        Get.offAllNamed(RoutesName.loginScreen);
      }
    );
  }
}
