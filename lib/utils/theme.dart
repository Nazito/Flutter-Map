import 'package:flutter/material.dart';
import 'package:my_app/utils/constants.dart';

ThemeData basicTheme() => ThemeData(
    brightness: Brightness.dark,
    primaryColor: themePrimaryColor,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontSize: largeTextSize,
          color: themeSecondaryColor,
          fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          fontSize: largeTextSize,
          color: themePrimaryColor,
          fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(
        fontSize: mediumTextSize,
        color: themePrimaryColor,
      ),
      bodyMedium: TextStyle(
          fontSize: bodyTextSize,
          color: themePrimaryColor,
          fontWeight: FontWeight.w400),
    ));
