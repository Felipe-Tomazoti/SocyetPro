class ValidationService {
  static bool isValidPassword(String password) {
    if (password.length < 8) return false;

    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacter = password.contains(RegExp(r'[!@#\$&*~]'));

    return hasUppercase && hasLowercase && hasDigit && hasSpecialCharacter;
  }
}
