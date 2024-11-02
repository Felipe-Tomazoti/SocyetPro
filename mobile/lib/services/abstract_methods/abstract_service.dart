import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class AbstractService<T> {
  final String url = "http://localhost:3000";

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(T object);

  Future<List<T>> getAll() async {
    var response = await http.get(Uri.parse("$url/${recurso()}"));
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body) as List;
      return jsonList.map((json) => fromJson(json)).toList();
    } else {
      throw Exception("Falha ao carregar os dados");
    }
  }

  Future<T> getById(String id) async {
    var response = await http.get(Uri.parse("$url/${recurso()}/$id"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return fromJson(jsonResponse);
    } else {
      throw Exception("Falha ao carregar o dado");
    }
  }

  Future<Map<String, dynamic>> post(T object) async {
    var response = await http.post(
      Uri.parse("$url/${recurso()}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(toJson(object)),
    );

    if (response.statusCode == 201) {
      return {"status": 201, "message": "Criação feita com sucesso!"};
    } else {
      return {
        "status": response.statusCode,
        "message": "Erro: ${response.body}"
      };
    }
  }

  Future<Map<String, dynamic>> delete(String id) async {
    var response = await http.delete(Uri.parse("$url/${recurso()}/$id"));
    if (response.statusCode == 204) {
      return {"status": 204, "message": "Exclusão feita com sucesso!"};
    } else {
      return {
        "status": response.statusCode,
        "message": "Erro: ${response.body}"
      };
    }
  }

  Future<Map<String, dynamic>> update(String id, T object) async {
    var response = await http.put(
      Uri.parse("$url/${recurso()}/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(toJson(object)),
    );
    if (response.statusCode == 202) {
      return {"status": 202, "message": "Atualização feita com sucesso!"};
    } else {
      return {
        "status": response.statusCode,
        "message": "Erro: ${response.body}"
      };
    }
  }

  String recurso();
}
