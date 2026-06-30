import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';

// tela para o usuario entrar no sistema
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController(text: 'admin');
  final _senhaController = TextEditingController();
  bool _erro = false;
  bool _carregando = false;

  // faz a validacao e tenta o login
  void _entrar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _carregando = true;
      _erro = false;
    });

    await Future.delayed(const Duration(milliseconds: 500)); // simula rede

    final store = context.read<DataStore>();
    final sucesso = store.login(_usuarioController.text, _senhaController.text);

    setState(() => _carregando = false);

    if (sucesso) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _erro = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 84),
                const SizedBox(height: 12),
                const Text(
                  'ROTA',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text('Gestão de Rota, Frota e Estoque'),
                const SizedBox(height: 32),
                // campo para o nome de usuario
                TextFormField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(
                    labelText: 'Usuário',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe o usuário' : null,
                ),
                const SizedBox(height: 16),
                // campo para a senha secreta
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe a senha' : null,
                ),
                if (_erro)
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                        'Usuário ou senha inválidos. Dica: senha = 1234',
                        style: TextStyle(color: Colors.red)),
                  ),
                const SizedBox(height: 24),
                // botao que aciona o login
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _carregando ? null : _entrar,
                    child: _carregando
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Entrar'),
                  ),
                ),
                const SizedBox(height: 24),
                Image.asset(
                  'assets/images/bandeira-do-brasil.png',
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
