import 'package:flutter/material.dart';

/// Design tokens for MuslimAll — "lantern at night" palette: a deep indigo
/// night sky with warm amber lantern-light accents on a warm sand ground.
/// Distinct from a daytime mosque-tilework look; evokes tahajjud/night
/// prayer stillness rather than a generic Material app.
class AppColors {
  AppColors._();

  static const Color indigoDeep = Color(0xFF161B33);
  static const Color indigo = Color(0xFF232C55);
  static const Color indigoLight = Color(0xFF3A4576);
  static const Color amber = Color(0xFFE0A458);
  static const Color amberLight = Color(0xFFF3C989);
  static const Color amberDeep = Color(0xFFB9832F);
  static const Color sand = Color(0xFFF6EFE3);
  static const Color card = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF1F2233);
  static const Color inkMuted = Color(0xFF6B6F86);
  static const Color divider = Color(0xFFE4DCC8);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.sand,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.indigo,
        secondary: AppColors.amber,
        surface: AppColors.card,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.indigoDeep,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.amber,
          foregroundColor: AppColors.indigoDeep,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
    );
  }
}
