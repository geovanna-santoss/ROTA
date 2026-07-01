import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/data_store.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

/// Ponto de entrada da aplicação Flutter.
void main() {
  runApp(const TransporteApp());
}

/// Componente raiz responsável por injetar estado e configurar rotas/tema.
class TransporteApp extends StatelessWidget {
  const TransporteApp({super.key});

  @override
  /// Monta a estrutura principal da aplicação.
  Widget build(BuildContext context) {
    // fornece os dados para todo o app
    return ChangeNotifierProvider(
      create: (_) => DataStore(),
      child: MaterialApp(
        title: 'ROTA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF007A33),
            primary: const Color(0xFF007A33),
            secondary: const Color(0xFF002776),
            tertiary: const Color(0xFFE5B800),
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        // define a tela inicial e as rotas
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
