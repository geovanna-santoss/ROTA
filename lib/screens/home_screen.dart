import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';
import 'cadastro_menu_screen.dart';
import 'rota_screen.dart';
import 'estoque_screen.dart';
import 'indicadores_screen.dart';

/// Tela principal com navegação por abas e resumo operacional.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indiceAtual = 0;

  // titulos para cada aba do menu
  static const _titulos = [
    'Início',
    'Cadastros',
    'Rotas',
    'Estoque',
    'Indicadores',
  ];

  /// Monta o conteúdo da aba inicial com cartões de resumo.
  Widget _telaInicio() {
    final store = context.watch<DataStore>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Olá, ${store.usuarioLogado ?? "usuário"}',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Resumo geral da operação de transportes'),
          const SizedBox(height: 16),
          // grade com os numeros principais
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _cardResumo(Icons.inventory_2, 'Itens em estoque',
                  '${store.totalProdutosEstoque}'),
              _cardResumo(
                  Icons.local_shipping, 'Veículos', '${store.veiculos.length}'),
              _cardResumo(
                  Icons.badge, 'Motoristas', '${store.motoristas.length}'),
              _cardResumo(Icons.alt_route, 'Rotas cadastradas',
                  '${store.rotas.length}'),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Acesso rápido',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          // botoes para navegar rapido entre as abas
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _botaoRapido(Icons.app_registration, 'Cadastros',
                  () => setState(() => _indiceAtual = 1)),
              _botaoRapido(Icons.alt_route, 'Rotas',
                  () => setState(() => _indiceAtual = 2)),
              _botaoRapido(Icons.list_alt, 'Estoque',
                  () => setState(() => _indiceAtual = 3)),
              _botaoRapido(Icons.bar_chart, 'Indicadores',
                  () => setState(() => _indiceAtual = 4)),
            ],
          ),
        ],
      ),
    );
  }

  /// Cria um cartão visual para exibir métrica resumida.
  Widget _cardResumo(IconData icone, String titulo, String valor) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icone, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(height: 8),
            Text(valor,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(titulo, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  /// Cria um atalho para navegação rápida entre as abas.
  Widget _botaoRapido(IconData icone, String texto, VoidCallback onTap) {
    return ActionChip(
      avatar: Icon(icone, size: 18),
      label: Text(texto),
      onPressed: onTap,
    );
  }

  @override
  /// Renderiza a estrutura da tela principal e o menu inferior.
  Widget build(BuildContext context) {
    // lista das telas disponiveis no menu
    final telas = [
      _telaInicio(),
      const CadastroMenuScreen(),
      const RotaScreen(),
      const EstoqueScreen(),
      const IndicadoresScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titulos[_indiceAtual]),
        actions: [
          // botao para deslogar e sair
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<DataStore>().logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: telas[_indiceAtual],
      // barra de navegacao inferior
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceAtual,
        onDestinationSelected: (i) => setState(() => _indiceAtual = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Início'),
          NavigationDestination(
              icon: Icon(Icons.app_registration),
              selectedIcon: Icon(Icons.app_registration),
              label: 'Cadastros'),
          NavigationDestination(
              icon: Icon(Icons.alt_route_outlined),
              selectedIcon: Icon(Icons.alt_route),
              label: 'Rotas'),
          NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2),
              label: 'Estoque'),
          NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart),
              label: 'Indicadores'),
        ],
      ),
    );
  }
}
