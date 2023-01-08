import 'package:flutter/material.dart';

import 'global_style.dart';

class ColorTheme {
  final ThemeData appTheme = ThemeData();
  Color primaryColor = purple;
  Color secondaryColor = amber;

  void setColor(int themeNumber) {
    switch (themeNumber) {
      case 0:
        primaryColor = purple;
        secondaryColor = amber;
        break;
      case 1:
        primaryColor = blue;
        secondaryColor = ligthBlue;
        break;
      case 2:
        primaryColor = red;
        secondaryColor = ligthRed;
        break;
      default:
        primaryColor = purple;
        secondaryColor = amber;
    }
  }

  ThemeData themeData(int themeNumber) {
    setColor(themeNumber);

    return appTheme.copyWith(
      colorScheme: appTheme.colorScheme.copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
