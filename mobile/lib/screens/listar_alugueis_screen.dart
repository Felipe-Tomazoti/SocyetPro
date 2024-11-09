import 'package:flutter/material.dart';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/services/campo_service.dart';

class ListaAlugueisScreen extends StatefulWidget {
  final String arenaId;

  const ListaAlugueisScreen({Key? key, required this.arenaId})
      : super(key: key);

  @override
  _ListaAlugueisScreenState createState() => _ListaAlugueisScreenState();
}

class _ListaAlugueisScreenState extends State<ListaAlugueisScreen> {
  final CampoService _campoService = CampoService();
  late Future<List<CampoModel>> _camposFuture;

  @override
  void initState() {
    super.initState();
    _camposFuture = _fetchCampos();
  }

  Future<List<CampoModel>> _fetchCampos() async {
    return await _campoService.getAllById(widget.arenaId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Aluguéis'),
      ),
      body: FutureBuilder<List<CampoModel>>(
        future: _camposFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Nenhum campo com aluguéis encontrados.'));
          } else {
            final campos = snapshot.data!;
            return ListView.builder(
              itemCount: campos.length,
              itemBuilder: (context, index) {
                final campo = campos[index];
                return ExpansionTile(
                  title: Text(
                      '${campo.nome} - ${campo.campo?.toString().split('.').last}'),
                  children: campo.alugueis.map((aluguel) {
                    return ListTile(
                      title: Text('Responsável: ${aluguel.responsavel}'),
                      subtitle: Text(
                        'Horário: ${aluguel.inicio.hour}:${aluguel.inicio.minute.toString().padLeft(2, '0')} - '
                        '${aluguel.fim.hour}:${aluguel.fim.minute.toString().padLeft(2, '0')}',
                      ),
                    );
                  }).toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
