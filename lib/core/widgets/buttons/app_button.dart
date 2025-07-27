import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../configs/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final double? width;
  final double height;
  final Function action;
  final bool enabled;
  final String title;
  final Color progressIndicatorColor;
  final Color textColor;
  final Color backGroundColor;
  final EdgeInsets padding;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  const AppButton({
    super.key,
    this.enabled = true,
    this.width,
    this.height = 45.0,
    this.progressIndicatorColor = AppColors.whiteColor,
    this.textColor = AppColors.whiteColor,
    this.backGroundColor = const Color(0xFF23EF91),
    this.child,
    this.border,
    this.padding = EdgeInsets.zero,
    required this.action,
    required this.title,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: Theme.of(context).elevatedButtonTheme,
      child: MyElevatedButton(
        color: backGroundColor,
        border: border,
        padding: padding,
        width: width,
        height: height,
        borderRadius: borderRadius??BorderRadius.all(Radius.circular(5.r)),
        onPressed: enabled ? () => action() : null,
        child: title.isNotEmpty
                ? title.toText(fontWeight: FontWeight.w900,fontSize: 15.sp, color: textColor, maxLines: 1,
            textOverflow: TextOverflow.ellipsis)
            : child ?? const SizedBox(),
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Color color;
  final VoidCallback? onPressed;
  final Widget child;
  final BoxBorder? border;
  final EdgeInsets padding;

  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 45.0,
    required this.color,
    this.padding = EdgeInsets.zero,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(3);
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: Container(
        width: width ?? 1.sw,
        height: height,
        decoration: BoxDecoration(
          border: border,
          color: color,
          borderRadius:borderRadius,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
