import 'package:flutter/material.dart';
import 'package:socyet_pro/enums/campo_enum.dart';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/services/arena_service.dart';
import 'package:socyet_pro/services/campo_service.dart';

class Campo extends StatefulWidget {
  const Campo({super.key});

  @override
  _CampoState createState() => _CampoState();
}

class _CampoState extends State<Campo> {
  Categoria? _selectedCampoSize;
  final CampoService _campoService = CampoService();
  final ArenaService _arenaService = ArenaService();
  late Future<List<CampoModel>> _camposFuture;

  late String nomeArena;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nomeArena = ModalRoute.of(context)!.settings.arguments as String;
    _camposFuture = _fetchCampos();
  }

  Future<List<CampoModel>> _fetchCampos() async {
    final arena = await _arenaService.getById(nomeArena);
    print('Arena selecionada: ${arena.nome}, ID: ${arena.id}');
    return arena.campos;
  }

  Future<void> _addCampo() async {
    if (_selectedCampoSize != null) {
      final novoCampo = CampoModel(campo: _selectedCampoSize!);
      final response = await _campoService.postWithArena(novoCampo, nomeArena);
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
        title: Text('Cadastrar Campos - $nomeArena'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Arena: $nomeArena',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
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
