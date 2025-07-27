import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:fantasy_cricket_app/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../configs/constants/app_colors.dart';
import '../../../../configs/di/service_locator.dart';
import '../../../../configs/provider/provider_view.dart';
import '../../../../configs/services/navigation/navigation_service_impl.dart';
import '../../../../core/widgets/text_fields/text_field_widget.dart';
import 'login_with_username_view_model.dart';

class LoginWithUsernameScreen extends ProviderView<LoginWithUsernameViewModel> {
  static final RouteDetails route = RouteDetails('login_with_username', '/login_with_username');

  const LoginWithUsernameScreen({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFF7F7F7),
            leading: IconButton(onPressed: (){
              navigationService.pop();
            }, icon: const Icon(Icons.arrow_back_outlined)),
          ),
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: viewModel.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  60.verticalSpace,
                  'Fantasy Cricket'.toText(
                      fontWeight: FontWeight.w600,
                      fontSize: 28.sp,
                      color: AppColors.blackColor),
                  'Please enter username and password to login'.toText(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.blackColor.withOpacity(0.6)),
                  25.verticalSpace,
                  TextFieldWidget(
                  controller: viewModel.usernameController,
                  hintText: 'Username',
                  keyboardType: TextInputType.text,
                  validator: (value)=>viewModel.userNameValidation(),
                  prefixIcon: Icon(Icons.person,
                      color: Colors.black.withOpacity(0.5), size: 20),
                  inputFormatter: [LengthLimitingTextInputFormatter(15)]),

                  15.verticalSpace,
                  TextFieldWidget(
                      controller: viewModel.passwordController,
                      hintText: 'Password',
                      keyboardType: TextInputType.text,
                      validator: (value)=>viewModel.passwordValidation(),
                      prefixIcon: Icon(Icons.lock,
                          color: Colors.black.withOpacity(0.5), size: 20),
                      inputFormatter: [LengthLimitingTextInputFormatter(8)]),

                  35.verticalSpace,
                  AppButton(
                    textColor: AppColors.blackColor.withOpacity(0.8),
                    action: () async {
                     viewModel.validateLogin();
                    },
                    title: 'Login'.toUpperCase(),
                  ),
                  34.verticalSpace,
                ],
              ),
            ),
          ),
        ));
  }

  @override
  LoginWithUsernameViewModel viewModelBuilder(BuildContext context) =>
      LoginWithUsernameViewModel();
}
