import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../configs/constants/app_colors.dart';
import '../../../../configs/constants/app_strings.dart';
import '../../../../configs/di/service_locator.dart';
import '../../../../configs/provider/provider_view.dart';
import '../../../../configs/services/navigation/navigation_service_impl.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import 'otp_view_model.dart';


class OtpScreen extends ProviderView<OtpViewModel> {
  static final RouteDetails route = RouteDetails('otp_screen', '/otp_screen');

  final String mobileNumber;

  const OtpScreen({super.key, required this.mobileNumber});

  @override
  Widget builder(BuildContext context, OtpViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF7F7F7),
          leading: IconButton(
              onPressed: () {
                navigationService.pop();
              },
              icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                80.verticalSpace,
                AppStrings.almostThere.toText(
                    fontWeight: FontWeight.w600,
                    fontSize: 28.sp,
                    color: AppColors.blackColor),
                'Please enter OTP sent on $mobileNumber'.toText(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: AppColors.blackColor.withOpacity(0.6)),
                25.verticalSpace,
                OtpTextField(
                  fieldHeight: 45.h,
                  fieldWidth: 45.w,
                  borderWidth: 0.8.w,
                  contentPadding: EdgeInsets.all(10.r),
                  borderRadius: BorderRadius.circular(8.r),
                  alignment: Alignment.center,
                  numberOfFields: 6,
                  focusedBorderColor: Colors.blue,
                  enabledBorderColor: const Color(0xFF7E7E7E).withOpacity(0.5),
                  borderColor: const Color(0xFF7E7E7E).withOpacity(0.5),
                  enabled: true,
                  // focusedBorderColor: const Color(0xFF2550D4),
                  showFieldAsBox: true,
                  filled: true,
                  fillColor: Colors.white,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    viewModel.otpCode = verificationCode;
                  }, // end onSubmit
                ),
                40.verticalSpace,
                AppButton(
                  height: 52.h,
                  textColor: AppColors.blackColor.withOpacity(0.8),
                  action: () async {
                    var errorMsg = viewModel.otpValidation();
                    if (errorMsg.isNotEmpty) {
                      navigationService.showSnackBar(errorMsg);
                    } else {
                      bool canAttempt = await viewModel.canAttemptOtp();
                      if (!canAttempt) {
                        navigationService.showSnackBar(
                            'You are temporarily blocked. Try after 2 minutes.');
                      } else {
                        viewModel.verifyOtp();
                      }
                    }
                  },
                  title: AppStrings.verify.toUpperCase(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  OtpViewModel viewModelBuilder(BuildContext context) {
    return OtpViewModel();
  }
}
