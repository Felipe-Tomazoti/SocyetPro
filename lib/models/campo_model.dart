class CampoModel {
  final String nome;
  final List<String> campos;

  CampoModel({
    required this.nome,
    List<String>? campos,
  }) : campos = campos ?? [];

  void addCampo(String campo) {
    campos.add(campo);
  }
}