import 'package:fantasy_cricket_app/configs/di/service_locator.dart';
import 'package:fantasy_cricket_app/configs/provider/base_view_model.dart';
import 'package:fantasy_cricket_app/core/data_source/shared_preferences/preference_key.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/create_team/create_team_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpViewModel extends BaseViewModel {
  static const String validOtp = '000000';
  static const int maxAttempts = 2;
  static const Duration blockDuration = Duration(minutes: 2);
  static const Duration windowDuration = Duration(minutes: 30);

  String otpCode = '';
  String mobileNo = '';

  String otpValidation() {
    if (otpCode.isEmpty) {
      return "Please enter otp";
    } else if (otpCode.length != 6) {
      return "Please enter valid otp";
    }
    return '';
  }

  Future<void> recordFailedAttempt() async {
    final now = DateTime.now();
    int attempts =
    await sharedPreferencesService.getInt(PreferenceKeys.attemptCountKey);

    if (attempts == 0) {
      sharedPreferencesService.addInt(
          PreferenceKeys.firstAttemptKey, now.millisecondsSinceEpoch);
    }

    attempts++;
    sharedPreferencesService.addInt(PreferenceKeys.attemptCountKey, attempts);

    if (attempts >= maxAttempts) {
      sharedPreferencesService.addInt(
          PreferenceKeys.lastBlockedTimeKey, now.millisecondsSinceEpoch);
    }
  }

  Future<bool> canAttemptOtp() async {
    final now = DateTime.now();
    final attemptCount =
    await sharedPreferencesService.getInt(PreferenceKeys.attemptCountKey);
    final firstAttemptMillis =
    await sharedPreferencesService.getInt(PreferenceKeys.firstAttemptKey);
    final lastBlockedMillis = await sharedPreferencesService
        .getInt(PreferenceKeys.lastBlockedTimeKey);

    if (firstAttemptMillis != null) {
      final firstAttemptTime =
      DateTime.fromMillisecondsSinceEpoch(firstAttemptMillis);
      final windowPassed = now.difference(firstAttemptTime) > windowDuration;

      if (windowPassed) {
        await resetOtpState();
        return true;
      }
    }

    if (attemptCount >= maxAttempts && lastBlockedMillis != null) {
      final lastBlockedTime =
      DateTime.fromMillisecondsSinceEpoch(lastBlockedMillis);
      final blockedPassed = now.difference(lastBlockedTime) > blockDuration;

      if (blockedPassed) {
        // allow attempt again within same 30-minute window (don't reset)
        return true;
      } else {
        return false; // still blocked
      }
    }

    return true; // allowed
  }

  Future<void> resetOtpState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PreferenceKeys.attemptCountKey);
    await prefs.remove(PreferenceKeys.firstAttemptKey);
    await prefs.remove(PreferenceKeys.lastBlockedTimeKey);
  }

  Future<void> verifyOtp() async {
    if (otpCode == validOtp) {
      await resetOtpState();
      navigationService.showSnackBar('OTP Verified Successfully!');
      sharedPreferencesService.addBoolean(PreferenceKeys.isUserLoggedIn, true);
      navigationService.goToRoute(CreateTeamScreen.route.name);
    } else {
      await recordFailedAttempt();
      navigationService.showSnackBar('Incorrect OTP. Try again.');
    }
  }
}
