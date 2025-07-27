import 'package:fantasy_cricket_app/configs/di/service_locator.dart';
import 'package:fantasy_cricket_app/configs/provider/base_view_model.dart';
import 'package:fantasy_cricket_app/core/data_source/shared_preferences/preference_key.dart';
import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:fantasy_cricket_app/feature/auth/presentation/otp_screen/otp_screen.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/create_team/create_team_screen.dart';
import 'package:flutter/material.dart';

class LoginWithUsernameViewModel extends BaseViewModel {
  static const String validUsername = 'Fantasy';
  static const String validPassword = 'Test@123';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void validateLogin() {
    var validate = formKey.currentState!.validate();
    if (validate) {
      if ((usernameController.text == validUsername) &&
          (passwordController.text == validPassword)) {
        sharedPreferencesService.addBoolean(PreferenceKeys.isUserLoggedIn, true);
        navigationService.goToRoute(CreateTeamScreen.route.name);
      }
      else{
        navigationService.showSnackBar("Invalid username or password");
      }
    }
  }

  String? userNameValidation() {
    if (usernameController.text.isEmpty) {
      return "Please enter username";
    }
    return null;
  }

  String? passwordValidation() {
    if (passwordController.text.isEmpty) {
      return "Please enter password";
    }
    return null;
  }
}
