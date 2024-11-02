import 'dart:convert';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/services/abstract_methods/abstract_service.dart';

class CampoService extends AbstractService<CampoModel> {
  @override
  String recurso() {
    return "campo";
  }

  @override
  CampoModel fromJson(Map<String, dynamic> json) {
    return CampoModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CampoModel object) {
    return object.toJson();
  }
}
