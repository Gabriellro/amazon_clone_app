import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

TextTheme customTextThemeLight() {
  return TextTheme(
    displayLarge: GoogleFonts.quicksand(
      fontSize: 98,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    displayMedium: GoogleFonts.quicksand(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    displaySmall: GoogleFonts.quicksand(
      fontSize: 49,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: GoogleFonts.quicksand(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headlineSmall: GoogleFonts.quicksand(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    labelLarge: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    bodySmall: GoogleFonts.quicksand(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelSmall: GoogleFonts.quicksand(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );
}

TextTheme customTextThemeDark() {
  return TextTheme(
    displayLarge: GoogleFonts.quicksand(
      fontSize: 98,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),
    displayMedium: GoogleFonts.quicksand(
      fontSize: 61,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    ),
    displaySmall: GoogleFonts.quicksand(
      fontSize: 49,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.quicksand(
      fontSize: 35,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.25,
      color: DarkColors.textDark,
    ),
    headlineSmall: GoogleFonts.quicksand(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
      color: DarkColors.textDark.withOpacity(0.3),
    ),
    bodyLarge: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.25,
      color: DarkColors.textDark.withOpacity(
        0.3,
      ),
    ),
    labelLarge: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.25,
    ),
    bodySmall: GoogleFonts.quicksand(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
      color: DarkColors.textDark.withOpacity(0.3),
    ),
    labelSmall: GoogleFonts.quicksand(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.5,
    ),
  );
}
