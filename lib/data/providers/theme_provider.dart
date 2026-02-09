import 'package:flutter/material.dart';
import 'package:noteflow/core/services/shared_preference/app_preference.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool getThemeValue() => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void updateTheme({required bool value}) async {
    _isDarkMode = value;
    await AppPreference.setTheme(value);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    _isDarkMode = await AppPreference.getTheme();
    notifyListeners();
  }
}
