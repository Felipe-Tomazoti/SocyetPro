import 'package:flutter/material.dart';
import 'package:socyet_pro/models/campo_model.dart';

class CampoCadastro extends StatefulWidget {
  const CampoCadastro({super.key});

  @override
  _CampoCadastroState createState() => _CampoCadastroState();
}

class _CampoCadastroState extends State<CampoCadastro> {
  late CampoModel _filialDetails;
  int _campoCounter = 1;
  String? _selectedCampoSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String nomeFilial = ModalRoute.of(context)!.settings.arguments as String;
    _filialDetails = CampoModel(nome: nomeFilial);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Filial: ${_filialDetails.nome}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cadastrar Campo:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _selectedCampoSize,
              items: const [
                DropdownMenuItem(child: Text('Campo Médio (12 jogadores)'), value: 'medio'),
                DropdownMenuItem(child: Text('Campo Grande (14 jogadores)'), value: 'grande'),
              ],
              hint: const Text('Selecione o tipo de campo'),
              onChanged: (value) {
                setState(() {
                  _selectedCampoSize = value;
                });
              },
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _selectedCampoSize == null
                  ? null
                  : () {
                setState(() {
                  if (_selectedCampoSize != null) {
                    _filialDetails.addCampo('Campo $_campoCounter ($_selectedCampoSize)');
                    _campoCounter++;
                    _selectedCampoSize = null;
                  }
                });
              },
              child: const Text('Confirmar Cadastro do Campo'),
            ),

            const SizedBox(height: 20),
            const Text('Campos Cadastrados:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _filialDetails.campos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filialDetails.campos[index]),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/marcarHorario',
                        arguments: _filialDetails.campos[index],
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
