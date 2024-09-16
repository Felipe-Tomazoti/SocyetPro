import 'package:flutter/material.dart';
import 'package:socyet_pro/screens/homePage_screen.dart';
import 'package:socyet_pro/screens/login_screen.dart';
import 'screens/arenaCadastro_screen.dart';
import 'screens/campoCadastro_screen.dart';
import 'screens/marcarHorario_screen.dart';

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
        '/login': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/filialCadastro': (context) => const ArenaCadastro(),
        '/detalhesFilial': (context) => const CampoCadastro(),
        '/marcarHorario': (context) => const MarcarHorario(),
      },
    );
  }
}
