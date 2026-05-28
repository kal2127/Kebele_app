import 'package:flutter/material.dart';

class AppTheme {
  static const deepGreen = Color(0xFF075E32);
  static const forestGreen = Color(0xFF38652B);
  static const gold = Color(0xFFF3B536);
  static const lightBackground = Color(0xFFF7FAF6);
  static const darkBackground = Color(0xFF08130F);
  static const darkSurface = Color(0xFF11221B);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: deepGreen,
      brightness: Brightness.light,
      primary: deepGreen,
      secondary: gold,
      surface: Colors.white,
      background: lightBackground,
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: lightBackground,
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        foregroundColor: Color(0xFF06130D),
        elevation: 0,
        centerTitle: false,
      ),
      shadowColor: Colors.black.withOpacity(0.08),
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: deepGreen,
      brightness: Brightness.dark,
      primary: const Color(0xFF4ED08A),
      secondary: gold,
      surface: darkSurface,
      background: darkBackground,
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      shadowColor: Colors.black.withOpacity(0.28),
    );
  }

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontWeight: FontWeight.w800),
        headlineMedium: TextStyle(fontWeight: FontWeight.w800),
        titleLarge: TextStyle(fontWeight: FontWeight.w800),
        titleMedium: TextStyle(fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(height: 1.35),
        bodyMedium: TextStyle(height: 1.35),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.18)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
