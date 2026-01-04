import 'package:flutter/material.dart';
import '../Routes/app_navigation.dart';
import '../Themes/app_colors.dart';

void showCustomSnackBar({
  required String? message,
  Color? backgroundColor,
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 3),
  SnackBarAction? action,
  double borderRadius = 20.0,
  EdgeInsetsGeometry? padding,
}) {
  final snackBar = SnackBar(
    content: Container(
      padding: padding ?? const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary500,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Text(
          message ?? '',
          style: TextStyle(color: textColor, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    backgroundColor: Colors.transparent, // Prevents default Snackbar background
    elevation: 0, // Removes shadow
    duration: duration,
    behavior: SnackBarBehavior.floating, // Makes Snackbar float above content
    action: action,
  );

  ScaffoldMessenger.of(AppNavigation.currentContext).showSnackBar(snackBar);
}
