import 'package:flutter/material.dart';
import 'produto_crud_screen.dart';
import 'carga_crud_screen.dart';
import 'motorista_crud_screen.dart';
import 'veiculo_crud_screen.dart';

/// Exibe as opções de cadastros disponíveis no sistema.
class CadastroMenuScreen extends StatelessWidget {
  const CadastroMenuScreen({super.key});

  @override
  /// Renderiza a lista de atalhos para as telas de cadastro.
  Widget build(BuildContext context) {
    // define quais sao os itens de cadastro disponiveis
    final itens = [
      _ItemCadastro('Produtos', 'Itens de estoque transportados', Icons.inventory_2,
          const ProdutoCrudScreen()),
      _ItemCadastro('Cargas', 'Lotes de mercadoria por viagem', Icons.local_shipping,
          const CargaCrudScreen()),
      _ItemCadastro('Motoristas', 'Equipe responsável pelas entregas', Icons.badge,
          const MotoristaCrudScreen()),
      _ItemCadastro('Veículos', 'Frota disponível para as rotas', Icons.directions_car,
          const VeiculoCrudScreen()),
    ];

    // cria a lista visual na tela
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: itens.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final item = itens[i];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(item.icone, color: Colors.white),
            ),
            title: Text(item.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.subtitulo),
            trailing: const Icon(Icons.chevron_right),
            // abre a tela de cadastro escolhida
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item.tela),
            ),
          ),
        );
      },
    );
  }
}

/// Estrutura auxiliar para definir cada item do menu de cadastros.
class _ItemCadastro {
  final String titulo;
  final String subtitulo;
  final IconData icone;
  final Widget tela;

  _ItemCadastro(this.titulo, this.subtitulo, this.icone, this.tela);
}
