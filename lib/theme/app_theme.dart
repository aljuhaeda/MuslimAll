import 'package:flutter/material.dart';

/// Design tokens for MuslimAll — quiet, warm, neutral base with a single
/// restrained Islamic-identity accent (a deep muted teal, evoking mosque
/// tilework without being loud), plus a brass tone used sparingly for
/// small emphasis moments. Replaces the earlier "lantern at night"
/// indigo/amber identity with something closer to a well-designed book:
/// warm paper, generous whitespace, quiet color, one considered accent.
class AppColors {
  AppColors._();

  // Warm neutral ground — the base the whole app sits on.
  static const Color paper = Color(0xFFF7F2E7);
  static const Color card = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE6DDC7);

  // Warm ink, not cool black — text should feel like it's printed on the
  // paper tone above, not pasted on top of it.
  static const Color ink = Color(0xFF2B2620);
  static const Color inkMuted = Color(0xFF756C5C);
  static const Color inkFaint = Color(0xFFA79C89);

  // Primary accent: a deep, muted teal. Used for actionable elements
  // (buttons, active states, links) — quiet enough to sit in a neutral
  // page without dominating it.
  static const Color teal = Color(0xFF2F5D53);
  static const Color tealDeep = Color(0xFF1F423A);
  static const Color tealSoft = Color(0xFFDCE7E1);

  // Secondary accent: muted brass, spent sparingly (a single highlight
  // moment per screen — e.g. the current-prayer marker), never as a
  // large fill or repeated across many elements.
  static const Color brass = Color(0xFFAD7F35);
  static const Color brassSoft = Color(0xFFEFE3C7);

  // Deprecated aliases kept only so older references don't hard-crash
  // during the transition; new code should use the tokens above.
  static const Color indigo = teal;
  static const Color indigoDeep = tealDeep;
  static const Color indigoLight = tealSoft;
  static const Color amber = brass;
  static const Color amberLight = brassSoft;
  static const Color amberDeep = brass;
  static const Color sand = paper;
}

class AppTheme {
  AppTheme._();

  static const String displayFontFamily = 'Fraunces';

  static ThemeData get light {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);
    final textTheme = base.textTheme.apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.paper,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.teal,
        secondary: AppColors.brass,
        surface: AppColors.card,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.paper,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: displayFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColors.ink,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.2),
          elevation: 0,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.divider),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.divider),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? AppColors.teal : AppColors.inkFaint,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? AppColors.tealSoft : AppColors.divider,
        ),
      ),
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(fontFamily: displayFontFamily, fontWeight: FontWeight.w600),
        displayMedium: textTheme.displayMedium?.copyWith(fontFamily: displayFontFamily, fontWeight: FontWeight.w600),
        displaySmall: textTheme.displaySmall?.copyWith(fontFamily: displayFontFamily, fontWeight: FontWeight.w600),
        headlineLarge: textTheme.headlineLarge?.copyWith(fontFamily: displayFontFamily, fontWeight: FontWeight.w600),
        headlineMedium: textTheme.headlineMedium?.copyWith(fontFamily: displayFontFamily, fontWeight: FontWeight.w600),
        headlineSmall: textTheme.headlineSmall?.copyWith(fontFamily: displayFontFamily, fontWeight: FontWeight.w600),
        titleLarge: textTheme.titleLarge?.copyWith(fontFamily: displayFontFamily, fontWeight: FontWeight.w600),
      ),
    );
  }
}
