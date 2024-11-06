import 'package:socyet_pro/models/aluguel_model.dart';
import 'package:socyet_pro/services/abstract_methods/abstract_service.dart';
import 'package:http/http.dart' as http;

class AluguelService extends AbstractService<AluguelModel> {
  AluguelService({http.Client? client}) : super(client: client);

  @override
  String recurso() {
    return "aluguel";
  }

  @override
  AluguelModel fromJson(Map<String, dynamic> json) {
    return AluguelModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AluguelModel object) {
    return object.toJson();
  }
}
