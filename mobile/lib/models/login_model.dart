import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class LoginModel extends ChangeNotifier {
  final String id;
  String? email;
  String? pwd;

  LoginModel({String? id, required this.email, required this.pwd})
      : id = Uuid().v4() {}

  LoginModel.vazio()
      : id = Uuid().v4(),
        email = null,
        pwd = null;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(id: json['id'], email: json['email'], pwd: json['pwd']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'pwd': pwd};
  }

  @override
  String toString() {
    return 'LoginModel{id: $id, email: $email, pwd: $pwd}';
  }

  void validationPwd() {
    if (pwd == null || pwd!.isEmpty) {
      throw ArgumentError('A senha não pode ser vazia');
    }
  }

  void validationEmail() {
    if (email == null || email!.isEmpty) {
      throw ArgumentError('O e-mail não pode ser vazio');
    }
  }
}
