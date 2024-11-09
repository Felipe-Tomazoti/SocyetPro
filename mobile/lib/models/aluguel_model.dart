import 'package:intl/intl.dart';

class AluguelModel {
  final String responsavel;
  final DateTime inicio;
  final DateTime fim;

  AluguelModel({
    required this.responsavel,
    required this.inicio,
    required this.fim,
  });

  factory AluguelModel.fromJson(Map<String, dynamic> json) {
    var formatter = DateFormat('yyyy-MM-dd HH:mm');
    return AluguelModel(
      responsavel: json['responsavel'],
      inicio: formatter.parse(json['inicio']),
      fim: formatter.parse(json['fim']),
    );
  }

  Map<String, dynamic> toJson() {
    var formatter = DateFormat('yyyy-MM-dd HH:mm');
    return {
      'responsavel': responsavel,
      'inicio': formatter.format(inicio),
      'fim': formatter.format(fim),
    };
  }

  @override
  String toString() {
    return 'AluguelModel{responsavel: $responsavel, horario: ${DateFormat('HH:mm').format(inicio)} - ${DateFormat('HH:mm').format(fim)}}';
  }
}
