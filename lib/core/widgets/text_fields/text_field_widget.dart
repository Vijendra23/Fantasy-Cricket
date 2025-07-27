import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../configs/constants/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String headingText;
  final int? maxLength;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPasswordField;
  final VoidCallback? onTapSuffix;
  final bool obscureText;
  final Color? hintTextColor;
  final bool autoFocus;
  final Color focusBorderColor;
  final bool? showCursor;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    this.onTap,
    required this.controller,
    this.labelText = "",
    this.headingText = "",
    this.hintText = "",
    this.readOnly = false,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.inputFormatter,
    this.focusNode,
    this.isPasswordField = false,
    this.onTapSuffix,
    this.obscureText = false,
    this.hintTextColor,
    this.autoFocus = false,
    this.focusBorderColor = const Color(0xFF3045FF),
    this.onChanged,
    this.showCursor,
    this.validator,
  });

  final double borderRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatter,
      showCursor: showCursor,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      focusNode: focusNode,
      autofocus: autoFocus,
      cursorColor: Colors.black,
      obscureText: obscureText,
      maxLength: maxLength,
      style: TextStyle(fontSize: 14.sp, color: AppColors.blackColor),
      keyboardType: keyboardType ?? TextInputType.text,
      readOnly: readOnly,
      decoration: InputDecoration(
          counterText: "", // Hides the "0/5" counter
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          focusColor: Colors.black,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const Color(0xFF7E7E7E).withOpacity(0.5), width: 0.6),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusBorderColor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const Color(0xFF7E7E7E).withOpacity(0.5), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.colorRed,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15.sp, color:  hintTextColor ?? Colors.black.withOpacity(0.5)),
          suffixIcon: isPasswordField
              ? IconButton(
                  constraints: const BoxConstraints(minWidth: 5, minHeight: 5),
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.blackColor.withOpacity(0.4),
                  ),
                  onPressed: onTapSuffix,
                )
              : Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: suffixIcon,
                ),
          prefixIconConstraints:
              BoxConstraints(maxWidth: 40.w, maxHeight: 40.h),
          suffixIconConstraints:
              BoxConstraints(maxWidth: 40.w, maxHeight: 40.h),
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: prefixIcon,
          )),
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
    );
  }
}
