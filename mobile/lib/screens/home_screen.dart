import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:socyet_pro/models/arena_model.dart';
import 'package:socyet_pro/widgets/home_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ArenaModel> _filiais = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Aproveite o melhor do APP! \n - Agendamento \n - Gerenciamento \n - E muito mais',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SUSE',
                  fontWeight: FontWeight.w400,
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
              '👇 Cadastre aqui 👇',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.pushNamed(context, '/arena');
                if (result != null && result is ArenaModel) {
                  setState(() {
                    _filiais.add(result);
                  });
                }
              },
              icon: const Icon(MdiIcons.soccerField),
              label: const Text('Cadastrar Arena'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Arenas Cadastradas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filiais.length,
                itemBuilder: (context, index) {
                  final filial = _filiais[index];
                  return ListTile(
                    title: Text(filial.nome),
                    subtitle: Text('Telefone: ${filial.telefone}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/campo',
                          arguments: filial.nome,
                        );
                      },
                    ),
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
