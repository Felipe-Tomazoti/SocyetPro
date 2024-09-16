import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socyet_pro/models/login_model.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text(
              'SocyetPro',
              style: TextStyle(
                fontFamily: 'Anton',
                fontSize: 24,
                height: -2,
              ),
            ),
          ),
          centerTitle: true,
          toolbarHeight: 150,
        ),
        body: Consumer<LoginModel>(
          builder: (context, loginModel, child) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sports_soccer,
                      size: 100,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bem-vindo ao SocyetPro!',
                      style: TextStyle(
                        fontFamily: 'SUSE',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      onChanged: (value) => loginModel.email = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                      onChanged: (value) => loginModel.password = value,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          if (loginModel.email.isEmpty) {
                            throw ArgumentError('O e-mail não pode estar vazio.');
                          }
                          if (loginModel.password.isEmpty) {
                            throw ArgumentError('A senha não pode estar vazia.');
                          }

                          loginModel.validatePassword();
                          loginModel.validatePassword();

                          Navigator.pushNamed(context, '/home');
                        } catch (e) {
                          if (e is ArgumentError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message)),
                            );
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
