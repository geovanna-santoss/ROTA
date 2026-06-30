import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';
import '../models/veiculo.dart';

// tela para cadastrar e gerenciar a frota de veiculos
class VeiculoCrudScreen extends StatelessWidget {
  const VeiculoCrudScreen({super.key});

  // abre a janelinha para preencher os dados do veiculo
  void _abrirFormulario(BuildContext context, {Veiculo? veiculo}) {
    final placaCtrl = TextEditingController(text: veiculo?.placa ?? '');
    final modeloCtrl = TextEditingController(text: veiculo?.modelo ?? '');
    final capCtrl = TextEditingController(text: veiculo?.capacidadeKg.toString() ?? '');
    bool disponivel = veiculo?.disponivel ?? true;
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setStateModal) => Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(veiculo == null ? 'Novo Veículo' : 'Editar Veículo',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                // campos de texto para placa, modelo e capacidade
                TextFormField(
                  controller: placaCtrl,
                  decoration: const InputDecoration(labelText: 'Placa'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                ),
                TextFormField(
                  controller: modeloCtrl,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                ),
                TextFormField(
                  controller: capCtrl,
                  decoration: const InputDecoration(labelText: 'Capacidade (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (v) => (double.tryParse(v ?? '') == null) ? 'Número inválido' : null,
                ),
                // interruptor de disponibilidade
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Disponível para rotas'),
                  value: disponivel,
                  onChanged: (v) => setStateModal(() => disponivel = v),
                ),
                const SizedBox(height: 8),
                // botao que salva os dados
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final store = ctx.read<DataStore>();
                    if (veiculo == null) {
                      store.addVeiculo(Veiculo(
                        id: store.novoId('v'),
                        placa: placaCtrl.text,
                        modelo: modeloCtrl.text,
                        capacidadeKg: double.parse(capCtrl.text),
                        disponivel: disponivel,
                      ));
                    } else {
                      store.updateVeiculo(Veiculo(
                        id: veiculo.id,
                        placa: placaCtrl.text,
                        modelo: modeloCtrl.text,
                        capacidadeKg: double.parse(capCtrl.text),
                        disponivel: disponivel,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<DataStore>();
    return Scaffold(
      appBar: AppBar(title: const Text('Veículos')),
      // lista os veiculos cadastrados
      body: store.veiculos.isEmpty
          ? const Center(child: Text('Nenhum veículo cadastrado.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: store.veiculos.length,
              itemBuilder: (context, i) {
                final v = store.veiculos[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: v.disponivel ? Colors.green : Colors.grey,
                      child: const Icon(Icons.directions_car, color: Colors.white),
                    ),
                    title: Text('${v.placa} • ${v.modelo}'),
                    subtitle: Text('Capacidade: ${v.capacidadeKg} kg\n${v.disponivel ? "Disponível" : "Indisponível"}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // botoes de edicao e exclusao
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _abrirFormulario(context, veiculo: v),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => store.deleteVeiculo(v.id),
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
