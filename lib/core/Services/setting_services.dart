import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingServices {
  static List<BoxShadow> mainShadow = [
    BoxShadow(
      color: Colors.black12.withValues(alpha: 0.1),
      blurRadius: 5,
      offset: const Offset(0, -2),
    ),
    BoxShadow(
      color: Colors.black12.withValues(alpha: 0.1),
      blurRadius: 5,
      offset: const Offset(0, 2),
    ),
  ];

  statusBarColor({
    required Color statusColor,
    required Brightness statusBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusColor,
        statusBarIconBrightness: statusBrightness,
      ),
    );
  }
}
