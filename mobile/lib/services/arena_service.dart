import 'dart:convert';
import 'package:socyet_pro/models/arena_model.dart';
import 'package:socyet_pro/services/abstract_methods/abstract_service.dart';
import 'package:http/http.dart' as http;

class ArenaService extends AbstractService<ArenaModel> {
  ArenaService({http.Client? client}) : super(client: client);

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

  @override
  Future<ArenaModel> getById(String name) async {
    final id = await getByName(name);
    return super.getById(id);
  }

  Future<String> getByName(String name) async {
    var uri =
        Uri.parse("$url/${recurso()}").replace(queryParameters: {'name': name});
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        return jsonResponse[0]['id'] as String;
      } else {
        throw Exception("Arena com o nome '$name' não encontrada");
      }
    } else {
      throw Exception("Falha ao carregar o dado");
    }
  }
}
