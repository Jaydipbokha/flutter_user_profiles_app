import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();

  factory AppColors() {
    return _instance;
  }

  AppColors._internal();

  static Color themeColor = Color(0xFF3453a2).withOpacity(0.3);
  static Color whiteColor = Color(0xFFFFFFFF);
  static Color blackColor = Color(0xFF000000);
  static Color greyBackGroundColor = Color(0xFFf6f6f6);
  static Color hintTextColor = Colors.grey.shade500;
  static Color blueColor = Colors.blueAccent;
  static Color transparentColor = Colors.transparent;
  static Color redColor = Colors.redAccent;
  static Color greenColor = Colors.green;
  static Color tableGraditentColor1 = Color(0xFFB2E5F8);
  static Color tableGraditentColor2 = Color(0xFFF2F3E2);

  static Color grey100 = const Color(0xFFD3D3D3);
  static Color grey200 = const Color(0xFFE5E4E2);
  static Color grey300 = const Color(0xFFC0C0C0);
}
