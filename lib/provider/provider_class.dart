import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider() {
    _loadThemeFromHive();   // <-- theme load on provider start
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Load theme from Hive
  void _loadThemeFromHive() {
    final box = Hive.box('settings');
    bool isDark = box.get('isDark', defaultValue: false);

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  /// Toggle + Save to Hive
  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;

    // Save to Hive
    Hive.box('settings').put('isDark', isOn);

    notifyListeners();
  }
}
