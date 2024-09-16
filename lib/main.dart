import 'package:flutter/material.dart';
import 'package:socyet_pro/screens/HomePage.dart';
import 'package:socyet_pro/screens/LoginPage.dart';
import 'screens/FilialCadastroPage.dart';
import 'screens/DetalhesFilialPage.dart';
import 'screens/MarcarHorarioPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocyetPro',
      theme: ThemeData(
        primaryColor: Colors.green[400],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[400],
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/filialCadastro': (context) => const FilialCadastroPage(),
        '/detalhesFilial': (context) => const DetalhesFilialPage(),
        '/marcarHorario': (context) => const MarcarHorarioPage(),
      },
    );
  }
}
