import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.lightBlue;
  static const Color backgroundColor = Colors.black;
  static const Color cardColor = Colors.white;
  static const Color textColor = Colors.white;
  static const Color blackTextColor = Colors.black;

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      centerTitle: true,
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textColor,
      ),
    ),
  );
}