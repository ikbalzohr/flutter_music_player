import 'package:flutter/material.dart';
import 'package:flutter_music_player/themes/dark_mode.dart';
import 'package:flutter_music_player/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initally, light mode
  ThemeData _themeData = lightMode;

  // get theme
  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  // toggle theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
  }
}
