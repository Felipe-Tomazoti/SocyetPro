import 'package:socyet_pro/models/login_model.dart';
import 'package:socyet_pro/services/abstract_methods/abstract_service.dart';

class LoginService extends AbstractService<LoginModel> {
  @override
  String recurso() {
    return "login";
  }

  @override
  LoginModel fromJson(Map<String, dynamic> json) {
    return LoginModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(LoginModel object) {
    return object.toJson();
  }
}
