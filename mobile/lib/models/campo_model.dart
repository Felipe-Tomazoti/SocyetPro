import 'package:socyet_pro/models/aluguel_model.dart';
import 'package:uuid/uuid.dart';
import '../enums/campo_enum.dart';

class CampoModel {
  final String id;
  Categoria? campo;
  final String? nome;
  String? arenaId;
  List<AluguelModel> alugueis = [];

  static int _counter = 1;

  CampoModel({String? id, required this.campo, String? nome, this.arenaId})
      : id = id ?? Uuid().v4(),
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

    if (json['alugueis'] != null) {
      campoModel.alugueis = (json['alugueis'] as List)
          .map((aluguelJson) => AluguelModel.fromJson(aluguelJson))
          .toList();
    }

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
      'alugueis': alugueis.map((aluguel) => aluguel.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CampoModel{id: $id, campo: $campo, nome: $nome, alugueis: $alugueis}';
  }

  bool adicionarAluguel(AluguelModel aluguel) {
    alugueis.add(aluguel);
    return true;
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
