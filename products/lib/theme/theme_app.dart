import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[350],
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith();
}
