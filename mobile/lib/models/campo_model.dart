import 'package:uuid/uuid.dart';
import '../enums/campo_enum.dart';

class CampoModel {
  final String id;
  final Categoria? campo;
  final String? nome;
  String? arenaId;

  static int _counter = 1;

  CampoModel({String? id, required this.campo, String? nome, this.arenaId})
      : id = Uuid().v4(),
        nome = nome ?? 'Campo ${_counter++}';

  CampoModel.vazio()
      : id = Uuid().v4(),
        nome = null,
        campo = null,
        arenaId = null;

  factory CampoModel.fromJson(Map<String, dynamic> json) {
    var campoModel = CampoModel(
      id: json['id'],
      campo: _fromStringToCategoria(json['campo']),
      nome: json['nome'],
      arenaId: json['arenaId'],
    );

    int nomeNumero = int.tryParse(json['nome']?.split(' ').last ?? '0') ?? 0;
    if (nomeNumero >= _counter) {
      _counter = nomeNumero + 1;
    }

    return campoModel;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'campo': campo?.toString().split('.').last,
      'arenaId': arenaId,
    };
  }

  @override
  String toString() {
    return 'CampoModel{id: $id, campo: $campo, nome: $nome}';
  }

  void validationCampo() {
    if (campo == null) {
      throw ArgumentError('O campo não pode ser vazio');
    }
  }

  static Categoria _fromStringToCategoria(String? value) {
    if (value == null) {
      throw ArgumentError('O valor da categoria não pode ser nulo');
    }
    return Categoria.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () =>
          throw ArgumentError('Categoria não encontrada para o valor: $value'),
    );
  }

  String get formatoCampo {
    return '$nome - ${campo?.toString().split('.').last}';
  }
}
