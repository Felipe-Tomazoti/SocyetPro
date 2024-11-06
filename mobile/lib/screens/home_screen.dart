import 'package:flutter/material.dart';
import 'package:socyet_pro/models/arena_model.dart';
import 'package:socyet_pro/enums/campo_enum.dart';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/screens/aluguel_screen.dart';
import 'package:socyet_pro/services/arena_service.dart';
import 'package:socyet_pro/services/campo_service.dart';
import 'package:socyet_pro/widgets/home_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Categoria? _selectedCampoSize;
  final CampoService _campoService = CampoService();
  final ArenaService _arenaService = ArenaService();
  late ArenaModel arenaSelecionada;
  late Future<ArenaModel> _arenaFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arenaSelecionada = ModalRoute.of(context)!.settings.arguments as ArenaModel;
    _arenaFuture = _fetchArenaData();
  }

  Future<ArenaModel> _fetchArenaData() async {
    return await _arenaService.getById(arenaSelecionada.id);
  }

  Future<void> _addCampo() async {
    if (_selectedCampoSize != null) {
      final novoCampo =
          CampoModel(campo: _selectedCampoSize!, arenaId: arenaSelecionada.id);
      final response =
          await _campoService.postWithArena(novoCampo, arenaSelecionada.id);
      if (response['status'] == 201) {
        setState(() {
          _arenaFuture = _fetchArenaData();
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
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                arenaSelecionada.nome,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Anton',
                ),
              ),
              const Text(
                'Gerencie os campos da sua arena!',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SUSE',
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        toolbarHeight: 170,
      ),
      drawer: HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Cadastrar Novo Campo:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
            const Text(
              'Campos Cadastrados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<ArenaModel>(
                future: _arenaFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.campos.isEmpty) {
                    return const Center(
                        child: Text('Nenhum campo cadastrado.'));
                  } else {
                    final campos = snapshot.data!.campos;
                    return ListView.builder(
                      itemCount: campos.length,
                      itemBuilder: (context, index) {
                        final campo = campos[index];
                        return ListTile(
                          title: Text(
                            '${campo.nome ?? 'Campo sem nome'} - ${campo.campo?.toString().split('.').last}',
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddAluguelScreen(campo: campo),
                              ),
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
