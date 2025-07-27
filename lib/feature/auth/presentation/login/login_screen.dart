import 'package:fantasy_cricket_app/configs/di/service_locator.dart';
import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:fantasy_cricket_app/core/widgets/buttons/app_button.dart';
import 'package:fantasy_cricket_app/feature/auth/presentation/login_with_username/login_with_username_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../configs/constants/app_colors.dart';
import '../../../../configs/constants/app_strings.dart';
import '../../../../configs/provider/provider_view.dart';
import '../../../../configs/services/navigation/navigation_service_impl.dart';
import '../../../../core/widgets/text_fields/text_field_widget.dart';
import 'login_view_model.dart';

class LoginScreen extends ProviderView<LoginViewModel> {
  static final RouteDetails route = RouteDetails('login', '/login');

  const LoginScreen({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: viewModel.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  80.verticalSpace,
                  AppStrings.welcomeToFantasyCricket.toText(
                      fontWeight: FontWeight.w600,
                      fontSize: 28.sp,
                      color: AppColors.blackColor),
                  AppStrings.validMobileToLoginLbl.toText(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.blackColor.withOpacity(0.6)),
                  25.verticalSpace,
                  TextFieldWidget(
                  controller: viewModel.mobileController,
                  hintText: AppStrings.mobile,
                  keyboardType: TextInputType.phone,
                  validator: (value)=>viewModel.mobileValidation(),
                  prefixIcon: Icon(Icons.phone_android_outlined,
                      color: Colors.black.withOpacity(0.5), size: 20),
                  inputFormatter: [LengthLimitingTextInputFormatter(10)]),
                  35.verticalSpace,
                  AppButton(
                    textColor: AppColors.blackColor.withOpacity(0.8),
                    action: () async {
                     viewModel.validateLogin();
                    },
                    title: 'Get Verification Code'.toUpperCase(),
                  ),
                  24.verticalSpace,
                  Center(
                    child: 'Or login with'.toText(
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.blackColor.withOpacity(0.4)),
                  ),
                  24.verticalSpace,
                  AppButton(
                    backGroundColor: const Color(0xFFEFEFEF),
                    textColor: AppColors.blackColor.withOpacity(0.8),
                    action: () async {
                     navigationService.pushScreen(LoginWithUsernameScreen.route.name);
                    },
                    title: 'Username/Password'.toUpperCase(),
                  ),
                  34.verticalSpace,
                ],
              ),
            ),
          ),
        ));
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) =>
      LoginViewModel();
}
