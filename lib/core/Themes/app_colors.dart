import 'package:flutter/material.dart';

class AppColors {
  /// Primary color shades based on main color (#00C65B).
  static const primary100 = Color(0xFFE6F9F0); // Lightest tint
  static const primary200 = Color(0xFFBFF0DB);
  static const primary300 = Color(0xFF80E0B7);
  static const primary400 = Color(0xFF33D18B);
  static const primary500 = Color(0xFF00C65B); // Base primary
  static const primary600 = Color(0xFF00B154);
  static const primary700 = Color(0xFF00994A); // Darker shade

  /// Secondary color shades (kept neutral & soft).
  static const secondary100 = Color(0xFFF4FFF9);
  static const secondary200 = Color(0xFFE9FFF3);
  static const secondary300 = Color(0xFFDBFBEA);
  static const secondary400 = Color(0xFFC9F5DC);
  static const secondary500 = Color(0xFFB3EFD0);
  static const secondary600 = Color(0xFF9ADFC1);

  /// Neutral and utility colors
  static const natural700 = Color(0xff262626);
  static const natural600 = Color(0xff515151);
  static const natural500 = Color(0xff7D7D7D);
  static const natural400 = Color(0xffA8A8A8);
  static const natural300 = Color(0xffD4D4D4);
  static const natural200 = Color(0xffE9E9E9);
  static const natural100 = Color(0xffffffff);

  static const iconPrimary = primary600;
  static const grayDark = Color(0xff4E4A4A);
  static const black700 = Color(0xff1C1F28);
  static const slider = Color(0xffDDDDDD);
  static const blue = Color(0xff2675EC);

  static const backgroundColor = secondary100;
  static const activeColor = primary700;

  /// Round button border color.
  static const Color roundButtonBorderColor = primary700;

  /// Black text color.
  static const textBlack = Colors.black;

  /// Error colors.
  static const errorColor = Color(0xffEB5757);
  static const darkRed = Color(0xffFF0E00);

  /// Background colors.
  static const scaffoldBackgroundColor = Color(0xFFF4FFF9);
  static const textFieldBackgroundColor = Color(0xffFAFAFA);

  /// Custom Material Color.
  static const MaterialColor primaryMaterialColor =
      MaterialColor(0xFF00C65B, <int, Color>{
        100: primary100,
        200: primary200,
        300: primary300,
        400: primary400,
        500: primary500,
        600: primary600,
        700: primary700,
      });
}
