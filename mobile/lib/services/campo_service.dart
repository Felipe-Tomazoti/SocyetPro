import 'dart:convert';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/services/abstract_methods/abstract_service.dart';
import 'arena_service.dart';
import 'package:http/http.dart' as http;

class CampoService extends AbstractService<CampoModel> {
  ArenaService arenaService = ArenaService();

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

  Future<Map<String, dynamic>> postWithArena(
      CampoModel object, String nomeArena) async {
    var arenaId = await arenaService.getByName(nomeArena);
    object.arenaId = arenaId;

    var camposAtuais = await _getCamposAtualizados(arenaId);

    var arenaUpdateResponse = await http.patch(
      Uri.parse("$url/arena/$arenaId"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'campos': [...camposAtuais, object.toJson()]
      }),
    );

    if (arenaUpdateResponse.statusCode == 200) {
      return await super.post(object);
    } else {
      throw Exception("Falha ao atualizar a arena com o novo campo");
    }
  }

  Future<List<CampoModel>> getAllById(String nomeArena) async {
    final id = await arenaService.getByName(nomeArena);
    print(id);
    var response = await http.get(Uri.parse("$url/arena/${id}"));
    print("getALLBYIDDDDD");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('campos') &&
          jsonResponse['campos'] is List) {
        return jsonResponse['campos']
            .map((json) => CampoModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Falha ao carregar os dados");
    }
  }

  Future<List<Map<String, dynamic>>> _getCamposAtualizados(
      String arenaId) async {
    var response = await http.get(Uri.parse("$url/arena/$arenaId"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['campos'] is List) {
        return List<Map<String, dynamic>>.from(jsonResponse['campos']);
      } else {
        return [];
      }
    } else {
      throw Exception("Falha ao carregar os campos da arena");
    }
  }
}
