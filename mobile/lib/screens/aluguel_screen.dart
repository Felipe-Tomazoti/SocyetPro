import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socyet_pro/models/aluguel_model.dart';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/services/aluguel_service.dart';
import 'package:socyet_pro/services/campo_service.dart';

class Aluguel extends StatefulWidget {
  final CampoModel campo;

  const Aluguel({Key? key, required this.campo}) : super(key: key);

  @override
  _AluguelState createState() => _AluguelState();
}

class _AluguelState extends State<Aluguel> {
  final _responsavelController = TextEditingController();
  DateTime? _inicio;
  DateTime? _fim;
  final CampoService _campoService = CampoService();
  final AluguelService _aluguelService = AluguelService();

  Future<void> _salvarAluguel() async {
    if (_inicio != null &&
        _fim != null &&
        _responsavelController.text.isNotEmpty) {
      final novoAluguel = AluguelModel(
        responsavel: _responsavelController.text,
        inicio: _inicio!,
        fim: _fim!,
      );
      await _aluguelService.post(novoAluguel);
      final sucesso =
          await _campoService.adicionarAluguel(widget.campo, novoAluguel);

      if (sucesso) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Aluguel não disponível nesse horário")),
        );
      }
    }
  }

  Future<void> _selecionarHorarioInicio() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        final now = DateTime.now();
        _inicio =
            DateTime(now.year, now.month, now.day, time.hour, time.minute);
      });
    }
  }

  Future<void> _selecionarHorarioFim() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        final now = DateTime.now();
        _fim = DateTime(now.year, now.month, now.day, time.hour, time.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Aluguel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _responsavelController,
              decoration:
                  const InputDecoration(labelText: 'Nome do Responsável'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selecionarHorarioInicio,
              child: Text(_inicio != null
                  ? 'Início: ${DateFormat.Hm().format(_inicio!)}'
                  : 'Selecionar Horário de Início'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _selecionarHorarioFim,
              child: Text(_fim != null
                  ? 'Fim: ${DateFormat.Hm().format(_fim!)}'
                  : 'Selecionar Horário de Fim'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarAluguel,
              child: const Text('Salvar Aluguel'),
            ),
          ],
        ),
      ),
    );
  }
}
