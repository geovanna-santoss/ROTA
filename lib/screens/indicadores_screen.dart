import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/data_store.dart';

/// Tela 6 - Indicadores e gráficos (funcionalidade adicional obrigatória:
/// "Gráficos e indicadores"). Mostra status das rotas e estoque por categoria.
class IndicadoresScreen extends StatelessWidget {
  const IndicadoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<DataStore>();
    final categorias = store.produtosPorCategoria;
    final cores = [Colors.blue, Colors.orange, Colors.green, Colors.purple, Colors.red, Colors.teal];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Status das rotas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const labels = ['Planejada', 'Andamento', 'Concluída'];
                        final i = value.toInt();
                        if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(labels[i], style: const TextStyle(fontSize: 11)),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(toY: store.rotasPlanejadas.toDouble(), color: Colors.blueGrey, width: 28),
                  ]),
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(toY: store.rotasEmAndamento.toDouble(), color: Colors.orange, width: 28),
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(toY: store.rotasConcluidas.toDouble(), color: Colors.green, width: 28),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text('Estoque por categoria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          SizedBox(
            height: 240,
            child: categorias.isEmpty
                ? const Center(child: Text('Sem dados de estoque.'))
                : PieChart(
                    PieChartData(
                      sections: categorias.entries.toList().asMap().entries.map((entry) {
                        final idx = entry.key;
                        final cat = entry.value;
                        return PieChartSectionData(
                          value: cat.value.toDouble(),
                          title: '${cat.key}\n${cat.value}',
                          color: cores[idx % cores.length],
                          radius: 90,
                          titleStyle: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      }).toList(),
                    ),
                  ),
          ),
          const SizedBox(height: 24),
          Card(
            color: const Color(0xFFE3EAF6),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Resumo geral', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('• Total de produtos em estoque: ${store.totalProdutosEstoque}'),
                  Text('• Veículos cadastrados: ${store.veiculos.length}'),
                  Text('• Motoristas cadastrados: ${store.motoristas.length}'),
                  Text('• Cargas cadastradas: ${store.cargas.length}'),
                  Text('• Rotas cadastradas: ${store.rotas.length}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
