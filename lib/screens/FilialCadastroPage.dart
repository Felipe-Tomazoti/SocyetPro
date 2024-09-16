import 'package:flutter/material.dart';

class FilialCadastroPage extends StatefulWidget {
  const FilialCadastroPage({super.key});

  @override
  _FilialCadastroPageState createState() => _FilialCadastroPageState();
}

class _FilialCadastroPageState extends State<FilialCadastroPage> {
  final TextEditingController _nomeController = TextEditingController();

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
              decoration: const InputDecoration(labelText: 'CNPJ'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'CEP'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Celular'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String nomeFilial = _nomeController.text;
                Navigator.pop(context, nomeFilial);
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.pushNamed(
                    context,
                    '/detalhesFilial',
                    arguments: nomeFilial,
                  );
                });
              },
              child: const Text('Cadastrar Filial e Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
