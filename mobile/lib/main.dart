import 'package:flutter/material.dart';
import 'package:socyet_pro/screens/arena_screen.dart';
import 'package:socyet_pro/screens/campo_screen.dart';
import 'package:socyet_pro/screens/home_screen.dart';
import 'screens/login_screen.dart';

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
        '/home': (context) => const Home(),
        '/arena': (context) => const Arena(),
        '/campo': (context) => const Campo()
      },
    );
  }
}
