import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

export 'app_colors.dart';
export 'app_images.dart';
export 'app_svg.dart';
export 'app_text_styles.dart';

/// Reference to the application theme.
abstract class AppTheme {
  AppTheme._();
  static const accentColor = AppColors.primary;
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  /// Light theme and its settings.
  static ThemeData light() {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: LightColors.background,
      backgroundColor: LightColors.background,
      iconTheme: const IconThemeData(color: LightColors.iconLight),
      textTheme: customTextThemeLight(),
      cardColor: LightColors.card,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        onPrimary: Colors.black,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        brightness: Brightness.light,
      ),
    );
  }

  /// Dark theme and its settings.
  static ThemeData dark() {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: DarkColors.background,
      iconTheme: const IconThemeData(color: DarkColors.iconDark),
      brightness: Brightness.dark,
      textTheme: customTextThemeDark(),
      backgroundColor: DarkColors.background,
      cardColor: DarkColors.card,
    );
  }
}
