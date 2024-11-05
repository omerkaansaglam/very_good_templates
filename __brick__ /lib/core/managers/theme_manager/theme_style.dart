import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';

sealed class ThemeStyle {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: ArteriaColors.primary, // Replace with your defined primary color
      onPrimary: ArteriaColors.onPrimary,
      secondary: ArteriaColors.secondary,
      onSecondary: ArteriaColors.onSecondary,
      surface: ArteriaColors.surface,
      onSurface: ArteriaColors.onSurface,
      error: ArteriaColors.error,
      onError: ArteriaColors.onError,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: ArteriaColors.black),
      backgroundColor: ArteriaColors.white,
      foregroundColor: ArteriaColors.white,
      surfaceTintColor: ArteriaColors.white,
      titleTextStyle: TextStyle(color: ArteriaColors.black),
    ),
    textTheme: Typography.englishLike2021.apply(
      bodyColor: ArteriaColors.black,
      displayColor: ArteriaColors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ArteriaColors.white,
        foregroundColor: ArteriaColors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ArteriaColors.white),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: ArteriaColors.primaryDark,
      onPrimary: ArteriaColors.onPrimaryDark,
      secondary: ArteriaColors.secondaryDark,
      onSecondary: ArteriaColors.onSecondaryDark,
      surface: ArteriaColors.surfaceDark,
      onSurface: ArteriaColors.onSurfaceDark,
      error: ArteriaColors.errorDark,
      onError: ArteriaColors.onErrorDark,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: ArteriaColors.white),
      backgroundColor: ArteriaColors.black,
      foregroundColor: ArteriaColors.black,
      surfaceTintColor: ArteriaColors.black,
      titleTextStyle: TextStyle(color: ArteriaColors.white),
    ),
    textTheme: Typography.englishLike2021.apply(
      bodyColor: ArteriaColors.white,
      displayColor: ArteriaColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ArteriaColors.black,
        foregroundColor: ArteriaColors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ArteriaColors.black),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
