import 'dart:convert';
import 'package:socyet_pro/models/arena_model.dart';
import 'package:socyet_pro/services/abstract_methods/abstract_service.dart';
import 'package:http/http.dart' as http;

class ArenaService extends AbstractService<ArenaModel> {
  @override
  String recurso() {
    return "arena";
  }

  @override
  ArenaModel fromJson(Map<String, dynamic> json) {
    return ArenaModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ArenaModel object) {
    return object.toJson();
  }
}
