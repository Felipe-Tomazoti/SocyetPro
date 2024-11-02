import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'campo_model.dart';

class ArenaModel extends ChangeNotifier {
  final String id;
  String nome;
  String cnpj;
  String telefone;
  List<CampoModel> campos;

  ArenaModel({
    String? id,
    required this.nome,
    required this.cnpj,
    required this.telefone,
    this.campos = const [],
  }) : id = Uuid().v4() {
    validationNome();
    validationCnpj();
    validationTelefone();
  }

  factory ArenaModel.fromJson(Map<String, dynamic> json) {
    var camposFromJson = (json['campos'] as List)
        .map((campoJson) => CampoModel.fromJson(campoJson))
        .toList();

    return ArenaModel(
      id: json['id'],
      nome: json['nome'],
      cnpj: json['cnpj'],
      telefone: json['telefone'],
      campos: camposFromJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'telefone': telefone,
      'campos': campos.map((campo) => campo.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ArenaModel{id: $id, nome: $nome, cnpj: $cnpj, telefone: $telefone}';
  }

  void validationNome() {
    if (nome == null || nome!.isEmpty) {
      throw ArgumentError('O nome não pode ser vazio');
    }
  }

  void validationCnpj() {
    if (cnpj == null || cnpj!.isEmpty) {
      throw ArgumentError('O cnpj não pode ser vazio');
    }
  }

  void validationTelefone() {
    if (cnpj == null || cnpj!.isEmpty) {
      throw ArgumentError('O telefone não pode ser vazio');
    }
  }
}
