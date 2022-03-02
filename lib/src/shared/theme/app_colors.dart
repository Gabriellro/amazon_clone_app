import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF008296);
  static const secondary = Color(0xFF84D8E3);
  static const tertiary = Color(0xFFC8F1E3);
  static const quaternary = Color(0xFFA5E6CE);

  static const white = Color(0xFFFFFFFF);
  static const softwhite = Color(0xFFFAFAFA);
  static const black = Color(0xFF000000);
  static const gray = Color(0xFFD8D8D8);
}

abstract class LightColors {
  static const card = AppColors.white;
  static const background = AppColors.gray;
  static const textLigth = AppColors.primary;
  static const iconLight = AppColors.primary;
}

abstract class DarkColors {
  static const background = AppColors.primary;
  static const card = AppColors.black;
  static const textDark = AppColors.white;
  static const iconDark = AppColors.white;
}
