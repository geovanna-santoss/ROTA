import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';
import '../models/rota.dart';

/// Tela 4 - Gestão de rotas de transporte (CRUD de rotas).
/// Vincula motorista, veículo e carga para cada viagem planejada.
class RotaScreen extends StatelessWidget {
  const RotaScreen({super.key});

  static const _statusOpcoes = ['Planejada', 'Em andamento', 'Concluida'];

  void _abrirFormulario(BuildContext context, {Rota? rota}) {
    final store = context.read<DataStore>();
    final origemCtrl = TextEditingController(text: rota?.origem ?? '');
    final destinoCtrl = TextEditingController(text: rota?.destino ?? '');
    String? motoristaId = rota?.motoristaId;
    String? veiculoId = rota?.veiculoId;
    String? cargaId = rota?.cargaId;
    String status = rota?.status ?? 'Planejada';
    DateTime dataSaida = rota?.dataSaida ?? DateTime.now();
    final formKey = GlobalKey<FormState>();

    if (store.motoristas.isEmpty || store.veiculos.isEmpty || store.cargas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cadastre ao menos um motorista, veículo e carga antes de criar uma rota.'),
      ));
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setStateModal) => Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(rota == null ? 'Nova Rota' : 'Editar Rota',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: origemCtrl,
                    decoration: const InputDecoration(labelText: 'Origem'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                  ),
                  TextFormField(
                    controller: destinoCtrl,
                    decoration: const InputDecoration(labelText: 'Destino'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: motoristaId,
                    decoration: const InputDecoration(labelText: 'Motorista'),
                    items: store.motoristas
                        .map((m) => DropdownMenuItem(value: m.id, child: Text(m.nome)))
                        .toList(),
                    onChanged: (v) => setStateModal(() => motoristaId = v),
                    validator: (v) => v == null ? 'Selecione um motorista' : null,
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: veiculoId,
                    decoration: const InputDecoration(labelText: 'Veículo'),
                    items: store.veiculos
                        .map((v) => DropdownMenuItem(value: v.id, child: Text('${v.placa} - ${v.modelo}')))
                        .toList(),
                    onChanged: (v) => setStateModal(() => veiculoId = v),
                    validator: (v) => v == null ? 'Selecione um veículo' : null,
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: cargaId,
                    decoration: const InputDecoration(labelText: 'Carga'),
                    items: store.cargas
                        .map((c) => DropdownMenuItem(value: c.id, child: Text(c.descricao)))
                        .toList(),
                    onChanged: (v) => setStateModal(() => cargaId = v),
                    validator: (v) => v == null ? 'Selecione uma carga' : null,
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: status,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: _statusOpcoes
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setStateModal(() => status = v ?? status),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Data de saída: ${dataSaida.day}/${dataSaida.month}/${dataSaida.year}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final escolhida = await showDatePicker(
                        context: ctx,
                        initialDate: dataSaida,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2030),
                      );
                      if (escolhida != null) setStateModal(() => dataSaida = escolhida);
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      if (rota == null) {
                        store.addRota(Rota(
                          id: store.novoId('r'),
                          origem: origemCtrl.text,
                          destino: destinoCtrl.text,
                          motoristaId: motoristaId!,
                          veiculoId: veiculoId!,
                          cargaId: cargaId!,
                          dataSaida: dataSaida,
                          status: status,
                        ));
                      } else {
                        store.updateRota(Rota(
                          id: rota.id,
                          origem: origemCtrl.text,
                          destino: destinoCtrl.text,
                          motoristaId: motoristaId!,
                          veiculoId: veiculoId!,
                          cargaId: cargaId!,
                          dataSaida: dataSaida,
                          status: status,
                        ));
                      }
                      Navigator.pop(ctx);
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<DataStore>();

    String nomeMotorista(String id) =>
        store.motoristas.firstWhere((m) => m.id == id, orElse: () => store.motoristas.first).nome;
    String placaVeiculo(String id) =>
        store.veiculos.firstWhere((v) => v.id == id, orElse: () => store.veiculos.first).placa;
    String descCarga(String id) =>
        store.cargas.firstWhere((c) => c.id == id, orElse: () => store.cargas.first).descricao;

    return Scaffold(
      body: store.rotas.isEmpty
          ? const Center(child: Text('Nenhuma rota cadastrada.\nToque em "+" para planejar uma nova rota.', textAlign: TextAlign.center))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: store.rotas.length,
              itemBuilder: (context, i) {
                final r = store.rotas[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.alt_route, color: Color(0xFF0D47A1)),
                    title: Text('${r.origem} → ${r.destino}'),
                    subtitle: Text(
                      'Motorista: ${nomeMotorista(r.motoristaId)}\n'
                      'Veículo: ${placaVeiculo(r.veiculoId)} • Carga: ${descCarga(r.cargaId)}\n'
                      'Saída: ${r.dataSaida.day}/${r.dataSaida.month}/${r.dataSaida.year} • Status: ${r.status}',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _abrirFormulario(context, rota: r),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => store.deleteRota(r.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
