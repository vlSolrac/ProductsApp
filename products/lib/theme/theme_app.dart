import 'package:flutter/material.dart';

class ThemeApp {
  static Color primary = Colors.deepPurple;

  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[350],
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: primary,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: primary,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
    ),
  );
}
