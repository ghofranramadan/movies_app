import 'package:flutter/material.dart';

class MoviesAppTheme {
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    backgroundColor: const Color(0xFFFFFFFF),
    indicatorColor: const Color(0xFF4A4B4D).withOpacity(0.50),
    primaryColor: const Color(0xFF667EEA),
    shadowColor: const Color(0xFF4A4B4D),
    highlightColor: const Color(0xFF667EEA).withOpacity(0.50),
    dividerColor: const Color(0xFF000000),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.grey[500],
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      headline2: const TextStyle(
        color: Color(0xFF000000),
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      headline3: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
      headline4: const TextStyle(
        color: Color(0xFF667EEA),
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    ),
  );
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF000000),
    textTheme: const TextTheme(),
  );
}
