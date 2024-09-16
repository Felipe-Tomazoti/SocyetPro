import 'package:flutter/material.dart';
import 'package:socyet_pro/models/arena_model.dart';

class ArenaCadastro extends StatefulWidget {
  const ArenaCadastro({super.key});

  @override
  _ArenaCadastroState createState() => _ArenaCadastroState();
}

class _ArenaCadastroState extends State<ArenaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Estabelecimento',
          style: TextStyle(fontFamily: 'Anton', fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Gerencie suas reservas de campos Socyets de forma prática e eficiente!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Estabelecimento'),
            ),
            TextField(
              controller: _cnpjController,
              decoration: const InputDecoration(labelText: 'CNPJ'),
            ),
            TextField(
              controller: _cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
            ),
            TextField(
              controller: _celularController,
              decoration: const InputDecoration(labelText: 'Celular'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  final filial = ArenaModel(
                    nome: _nomeController.text,
                    cnpj: _cnpjController.text,
                    cep: _cepController.text,
                    celular: _celularController.text,
                  );

                  Navigator.pop(context, filial);
                } catch (e) {
                  if (e is ArgumentError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message)),
                    );
                  }
                }
              },
              child: const Text('Cadastrar Filial e Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}