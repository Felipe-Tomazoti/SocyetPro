class ArenaModel {
  String nome;
  String cnpj;
  String cep;
  String celular;

  ArenaModel({
    String? nome,
    String? cnpj,
    String? cep,
    String? celular,
  })  : nome = nome ?? '',
        cnpj = cnpj ?? '',
        cep = cep ?? '',
        celular = celular ?? '' {
    _validateNome(this.nome);
    _validateCNPJ(this.cnpj);
    _validateCEP(this.cep);
    _validateCelular(this.celular);
  }

  void _validateNome(String nome) {
    if (nome.isEmpty) {
      throw ArgumentError('Nome do estabelecimento não pode ser vazio');
    }
  }

  void _validateCNPJ(String cnpj) {
    final cnpjRegex = RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$');
    if (cnpj.isNotEmpty && !cnpjRegex.hasMatch(cnpj)) {
      throw ArgumentError('CNPJ inválido. Deve estar no formato 12.345.678/0001-90');
    }
  }

  void _validateCEP(String cep) {
    final cepRegex = RegExp(r'^\d{5}-\d{3}$');
    if (cep.isNotEmpty && !cepRegex.hasMatch(cep)) {
      throw ArgumentError('CEP inválido. Deve estar no formato 12345-678');
    }
  }

  void _validateCelular(String celular) {
    final celularRegex = RegExp(r'^\(\d{2}\) \d{4,5}-\d{4}$');
    if (celular.isNotEmpty && !celularRegex.hasMatch(celular)) {
      throw ArgumentError('Celular inválido. Deve estar no formato (12) 34567-8901');
    }
  }
}