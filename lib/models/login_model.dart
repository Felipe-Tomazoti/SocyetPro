import 'package:flutter/material.dart';
import 'package:socyet_pro/services/validation_pwd.dart';

class LoginModel extends ChangeNotifier {
  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  void validateEmail() {
    if (_email.isEmpty) {
      throw ArgumentError('O e-mail não pode ser vazio');
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(_email)) {
      throw ArgumentError('E-mail inválido. Deve estar no formato exemplo@dominio.com');
    }
  }

  void validatePassword() {
    if (_password.isEmpty) {
      throw ArgumentError('A senha não pode ser vazia');
    }
    if (!ValidationPwd.isValidPassword(_password)) {
      throw ArgumentError('Senha inválida. A senha deve conter no mínimo 8 caracteres, incluindo letra maiúscula, minúscula, número e caractere especial.');
    }
  }
}
