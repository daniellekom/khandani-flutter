import 'package:email_validator/email_validator.dart';

class Validator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    if (!EmailValidator.validate(value)) {
      return "Invalid email";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "password is required";
    } else if (value.length < 6) {
      return "password must be 6 characters";
    }

    return null;
  }
}
