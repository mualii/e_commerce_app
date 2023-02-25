import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? validateEmail(String mail) {
    if (mail.isEmpty) {
      return "Required".tr();
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(mail)) {
      return "please_enter_valid_mail".tr();
    }
    return null;
  }

  static String? validateName(String name) {
    if (name.isEmpty) {
      return "Required".tr();
    }
    // ٠، ١، ٢، ٣، ٤، ، ٦، ٧، ٨، ٩
    if (name.length < 2) {
      return "should_be_at_least_2_alphabetic_characters".tr();
    }
    if (name.contains(RegExp(r'[0-9]')) ||
        name.contains("٠") ||
        name.contains("١") ||
        name.contains("٢") ||
        name.contains("٣") ||
        name.contains("٤") ||
        name.contains("٥") ||
        name.contains("٦") ||
        name.contains("٧") ||
        name.contains("٨") ||
        name.contains("٩")) {
      return "should_be_alphabetic_characters".tr();
    }
    if (name.length > 44) {
      return "the_number_of_characters_must_be_less_than_44".tr();
    }
    Pattern pattern4 = r'[!@#$%^&*(),.?":{}|<>]';
    RegExp regex4 = RegExp(pattern4.toString());
    if (regex4.hasMatch(name)) {
      return "please_don't_enter_special_characters".tr();
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password == null || password.isEmpty) {
      return "Required".tr();
    }
    if (password.length < 8) {
      return "please_enter_at_least_8_characters_in_password".tr();
    }
    return null;
  }

  static String? validateConfirmPassword(String password, String newPassword) {
    if (password.isEmpty) {
      return "Required".tr();
    }
    if (password.length < 8) {
      return "please_enter_at_least_8_characters_in_password".tr();
    }
    if (password != newPassword) {
      return "password_does_not_match".tr();
    }
    return null;
  }
}
