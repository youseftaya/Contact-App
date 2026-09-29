import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.lightBlue;

  static const Color darkBackgroundColor = Colors.black;
  static const Color darkCardColor = Colors.white;
  static const Color darkTextColor = Colors.white;
  static const Color blackTextColor = Colors.black;

  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color lightCardColor = Colors.white;
  static const Color lightTextColor = Colors.black;

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackgroundColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackgroundColor,
      foregroundColor: darkTextColor,
      centerTitle: true,
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: darkTextColor,
      ),
    ),
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackgroundColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackgroundColor,
      foregroundColor: lightTextColor,
      centerTitle: true,
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
  );
}