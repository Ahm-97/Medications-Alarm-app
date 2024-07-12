import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/common/constants/font_sizes.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xff7970e5),
      scaffoldBackgroundColor: const Color(0xff7970e5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff7970e5),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: FontSizes.large,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: FontSizes.medium,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: FontSizes.small,
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontSize: FontSizes.large,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff7970e5),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xff7970e5),
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
