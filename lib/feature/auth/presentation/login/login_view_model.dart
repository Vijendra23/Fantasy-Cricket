import 'package:fantasy_cricket_app/configs/di/service_locator.dart';
import 'package:fantasy_cricket_app/configs/provider/base_view_model.dart';
import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:fantasy_cricket_app/feature/auth/presentation/otp_screen/otp_screen.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {

  TextEditingController mobileController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void validateLogin(){
    var validate = formKey.currentState!.validate();
    if(validate){
     navigationService.pushScreen(OtpScreen.route.name,extra: {'mobile':mobileController.text});
    }
  }

  String? mobileValidation() {
    if (mobileController.text.isEmpty) {
      return "Please enter mobile no.";
    } else if (!mobileController.text.toString().isValidMobile()) {
      return "Please enter valid mobile no.";
    }
    return null;
  }
} 