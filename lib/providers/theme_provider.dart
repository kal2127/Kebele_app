import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._prefs) : _isDarkMode = _prefs.getBool(_themeKey) ?? false;

  static const _themeKey = 'is_dark_mode';

  final SharedPreferences _prefs;
  bool _isDarkMode;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();
    await _prefs.setBool(_themeKey, value);
  }

  Future<void> toggleTheme() => setDarkMode(!_isDarkMode);
}
