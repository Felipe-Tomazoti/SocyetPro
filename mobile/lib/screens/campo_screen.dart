import 'package:flutter/material.dart';
import 'package:socyet_pro/enums/campo_enum.dart';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/services/campo_service.dart';

class Campo extends StatefulWidget {
  const Campo({super.key});

  @override
  _CampoState createState() => _CampoState();
}

class _CampoState extends State<Campo> {
  Categoria? _selectedCampoSize;
  final CampoService _campoService = CampoService();
  late Future<List<CampoModel>> _camposFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _camposFuture = _fetchCampos();
  }

  Future<List<CampoModel>> _fetchCampos() async {
    return await _campoService.getAll();
  }

  Future<void> _addCampo() async {
    if (_selectedCampoSize != null) {
      final novoCampo = CampoModel(campo: _selectedCampoSize!);

      final response = await _campoService.post(novoCampo);
      if (response['status'] == 201) {
        setState(() {
          _camposFuture = _fetchCampos();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Campos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cadastrar Campo:', style: TextStyle(fontSize: 18)),
            DropdownButton<Categoria>(
              value: _selectedCampoSize,
              items: const [
                DropdownMenuItem(
                  child: Text('Amador'),
                  value: Categoria.amador,
                ),
                DropdownMenuItem(
                  child: Text('Semi-Profissional'),
                  value: Categoria.semiProfissional,
                ),
                DropdownMenuItem(
                  child: Text('Profissional'),
                  value: Categoria.profissional,
                ),
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
              onPressed: _selectedCampoSize == null ? null : _addCampo,
              child: const Text('Confirmar Cadastro do Campo'),
            ),
            const SizedBox(height: 20),
            const Text('Campos Cadastrados:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: FutureBuilder<List<CampoModel>>(
                future: _camposFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhum campo cadastrado.'));
                  } else {
                    final campos = snapshot.data!;
                    return ListView.builder(
                      itemCount: campos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            '${campos[index].nome ?? 'Campo sem nome'} - ${campos[index].campo?.toString().split('.').last}',
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/marcarHorario',
                              arguments: campos[index].nome,
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
