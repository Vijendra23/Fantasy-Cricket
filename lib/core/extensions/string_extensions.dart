import 'package:flutter/material.dart';

import '../../configs/constants/app_colors.dart';

extension StringExtensions on String {

  Text toText({
    double fontSize = 12.0,
    FontWeight fontWeight = FontWeight.w400,
    Color color  = AppColors.blackColor,
    int? maxLines,
    TextOverflow? textOverflow,
    TextAlign textAlign = TextAlign.start

  }){
    return Text(
      this,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color
      ),
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
    );
  }

  bool isValidMobile() {
    return RegExp(
      r'^[6-9]\d{9}$',
    ).hasMatch(this);
  }
}
