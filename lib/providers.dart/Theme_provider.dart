import 'package:cryptotracker/models/LocalStorage.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode thememode = ThemeMode.light;

  ThemeProvider(String theme) {
    if (theme == "light") {
      thememode = ThemeMode.light;
    } else {
      thememode = ThemeMode.dark;
    }
  }

  void toggleTheme() async {
    if (thememode == ThemeMode.light) {
      thememode = ThemeMode.dark;
      await LocalStorage.saveTheme("dark");
    } else {
      thememode = ThemeMode.light;
      await LocalStorage.saveTheme("light");
    }

    notifyListeners();
  }
}
