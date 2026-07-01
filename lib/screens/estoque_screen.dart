import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';

/// Tela de consulta e ajuste rápido do estoque de produtos.
class EstoqueScreen extends StatefulWidget {
  const EstoqueScreen({super.key});

  @override
  State<EstoqueScreen> createState() => _EstoqueScreenState();
}

class _EstoqueScreenState extends State<EstoqueScreen> {
  String _busca = '';

  @override
  /// Renderiza busca, tabela de estoque e total consolidado.
  Widget build(BuildContext context) {
    final store = context.watch<DataStore>();
    // filtra os produtos conforme o que o usuario digita na busca
    final produtos = store.produtos
        .where((p) => p.nome.toLowerCase().contains(_busca.toLowerCase()))
        .toList();

    return Column(
      children: [
        // campo para pesquisar produtos pelo nome
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Buscar produto...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (v) => setState(() => _busca = v),
          ),
        ),
        // tabela com as informacoes detalhadas do estoque
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
                columns: const [
                  DataColumn(label: Text('Produto')),
                  DataColumn(label: Text('Categoria')),
                  DataColumn(label: Text('Quantidade'), numeric: true),
                  DataColumn(label: Text('Peso (kg)'), numeric: true),
                  DataColumn(label: Text('Ações')),
                ],
                rows: produtos.map((p) {
                  return DataRow(cells: [
                    DataCell(Text(p.nome)),
                    DataCell(Text(p.categoria)),
                    DataCell(Text('${p.quantidade}')),
                    DataCell(Text('${p.peso}')),
                    // botoes para aumentar ou diminuir a quantidade rapido
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, size: 20),
                          onPressed: p.quantidade > 0
                              ? () {
                                  p.quantidade -= 1;
                                  store.updateProduto(p);
                                }
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, size: 20),
                          onPressed: () {
                            p.quantidade += 1;
                            store.updateProduto(p);
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
        // mostra a soma total de itens guardados
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Total em estoque: ${store.totalProdutosEstoque} unidades',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
