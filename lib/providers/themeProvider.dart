import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;
  late GetStorage _prefs;
  final String _themePreferenceKey = 'isDarkModeEnabled';

  ThemeProvider() {
    _themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
    _loadThemePreference();
  }

  ThemeData get themeData => _themeData;

  void _loadThemePreference() {
    _prefs = GetStorage();
    bool isDarkModeEnabled = _prefs.read(_themePreferenceKey) ?? false;
    _setThemeData(isDarkModeEnabled);
  }

  void _setThemeData(bool isDarkModeEnabled) {
    _themeData = isDarkModeEnabled
        ? ThemeData(
            colorScheme: ColorScheme.dark(),
            useMaterial3: true,
          )
        : ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          );
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDarkModeEnabled) async {
    await _prefs.write(_themePreferenceKey, isDarkModeEnabled);
    _setThemeData(isDarkModeEnabled);
  }
}
