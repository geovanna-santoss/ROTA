import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';

/// Tela 5 - Planilha de estoque: visão tabular de todos os produtos,
/// com busca e edição rápida de quantidade.
class EstoqueScreen extends StatefulWidget {
  const EstoqueScreen({super.key});

  @override
  State<EstoqueScreen> createState() => _EstoqueScreenState();
}

class _EstoqueScreenState extends State<EstoqueScreen> {
  String _busca = '';

  @override
  Widget build(BuildContext context) {
    final store = context.watch<DataStore>();
    final produtos = store.produtos
        .where((p) => p.nome.toLowerCase().contains(_busca.toLowerCase()))
        .toList();

    return Column(
      children: [
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
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFFE3EAF6)),
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
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Total em estoque: ${store.totalProdutosEstoque} unidades',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
