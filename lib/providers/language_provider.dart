import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider(this._prefs)
      : _locale = Locale(_prefs.getString(localeKey) ?? 'en'),
        _hasSelectedLanguage = _prefs.getBool(_selectedKey) ?? false;

  static const localeKey = 'selected_locale';
  static const _selectedKey = 'has_selected_language';

  final SharedPreferences _prefs;
  Locale _locale;
  bool _hasSelectedLanguage;

  Locale get locale => _locale;
  bool get isAmharic => _locale.languageCode == 'am';
  bool get hasSelectedLanguage => _hasSelectedLanguage;

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    _hasSelectedLanguage = true;
    notifyListeners();
    await _prefs.setString(localeKey, locale.languageCode);
    await _prefs.setBool(_selectedKey, true);
  }
}
