import 'package:flutter/material.dart';

class MarcarHorario extends StatefulWidget {
  const MarcarHorario({super.key});

  @override
  _MarcarHorarioState createState() => _MarcarHorarioState();
}

class _MarcarHorarioState extends State<MarcarHorario> {
  final TextEditingController _representanteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String campo = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Marcar Horários para $campo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Digite o nome do representante:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _representanteController,
              decoration: const InputDecoration(
                labelText: 'Nome do Representante',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Selecione o horário disponível:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: 24,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${index}:00 - ${index + 1}:00'),
                    onTap: () {
                      final representante = _representanteController.text;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Horário ${index}:00 - ${index + 1}:00 reservado para $campo\nRepresentante: $representante',
                          ),
                        ),
                      );
                      _representanteController.clear();
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
