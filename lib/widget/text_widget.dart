import 'package:flutter/material.dart';



class CustomText extends StatelessWidget {
  String? stTitle = '';
  String? stFontFamily = '';
  double? stFontSize = 14;
  Color? stColor;
  FontWeight? stFontWeight;
  int? stMaxLine = 1;
  TextAlign? stTextAlign;
  CustomText(
      {super.key,
      this.stTitle,
      this.stFontFamily,
      this.stFontSize,
      this.stColor,
      this.stFontWeight,
      this.stMaxLine,
      this.stTextAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      stTitle ?? '',
      style: TextStyle(
        color: stColor,
        fontSize: stFontSize,
        fontWeight: stFontWeight,
      ),
      maxLines: stMaxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: stTextAlign,
    );
  }
}
