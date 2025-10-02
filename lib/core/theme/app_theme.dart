// lib/theme/app_theme.dart
import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: whiteColor,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(backgroundColor: whiteColor),
  );
}
