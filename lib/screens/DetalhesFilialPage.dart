import 'package:flutter/material.dart';

class DetalhesFilialPage extends StatefulWidget {
  const DetalhesFilialPage({super.key});

  @override
  _DetalhesFilialPageState createState() => _DetalhesFilialPageState();
}

class _DetalhesFilialPageState extends State<DetalhesFilialPage> {
  final List<String> _campos = [];
  int _campoCounter = 1;

  @override
  Widget build(BuildContext context) {
    final String nomeFilial = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Filial: $nomeFilial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cadastrar Campo:', style: TextStyle(fontSize: 18)),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem(child: Text('Campo Médio (12 jogadores)'), value: 'medio'),
                  DropdownMenuItem(child: Text('Campo Grande (14 jogadores)'), value: 'grande'),
                ],
              onChanged: (value) {
                setState(() {
                  _campos.add('Campo $_campoCounter ($value)');
                  _campoCounter++;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Campos Cadastrados:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _campos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_campos[index]),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/marcarHorario',
                        arguments: _campos[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
