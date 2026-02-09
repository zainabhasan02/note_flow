import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const String KEYLOGIN = 'isLoggedIn';
  static const String KEYTHEME = 'isDarkMode';

  /* ---------------- Login ---------------- */
  static Future<void> setLogin(bool value) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(KEYLOGIN, value);
  }

  static Future<bool?> getLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(KEYLOGIN);
  }

  /* ---------------- Theme ---------------- */
  static Future<void> setTheme(bool isDark) async {
    final sharePref = await SharedPreferences.getInstance();
    sharePref.setBool(KEYTHEME, isDark);
  }

  static Future<bool> getTheme() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(KEYTHEME) ?? false;
  }

  /* ---------------- Generic ---------------- */
  static Future<String?> getString(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(key);
  }

  static Future<void> setString(String key, String value) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(key, value);
  }

  static Future<void> clear() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.clear();
  }
}
