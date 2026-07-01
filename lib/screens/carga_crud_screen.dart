import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';
import '../models/carga.dart';

/// Tela para cadastro e gerenciamento de cargas.
class CargaCrudScreen extends StatelessWidget {
  const CargaCrudScreen({super.key});

  // opcoes de status para a carga
  static const _statusOpcoes = ['Pendente', 'Em transporte', 'Entregue'];

  /// Abre o formulário para criação ou edição de carga.
  void _abrirFormulario(BuildContext context, {Carga? carga}) {
    final descCtrl = TextEditingController(text: carga?.descricao ?? '');
    final pesoCtrl = TextEditingController(text: carga?.pesoTotal.toString() ?? '');
    final origemCtrl = TextEditingController(text: carga?.origem ?? '');
    final destinoCtrl = TextEditingController(text: carga?.destino ?? '');
    String status = carga?.status ?? 'Pendente';
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
                Text(carga == null ? 'Nova Carga' : 'Editar Carga',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                // campos de entrada de dados
                TextFormField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                ),
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
                TextFormField(
                  controller: pesoCtrl,
                  decoration: const InputDecoration(labelText: 'Peso total (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (v) => (double.tryParse(v ?? '') == null) ? 'Número inválido' : null,
                ),
                // menu de selecao de status
                DropdownButtonFormField<String>(
                  initialValue: status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: _statusOpcoes
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => setStateModal(() => status = v ?? status),
                ),
                const SizedBox(height: 8),
                // salva os dados no sistema
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final store = ctx.read<DataStore>();
                    if (carga == null) {
                      store.addCarga(Carga(
                        id: store.novoId('c'),
                        descricao: descCtrl.text,
                        pesoTotal: double.parse(pesoCtrl.text),
                        origem: origemCtrl.text,
                        destino: destinoCtrl.text,
                        status: status,
                      ));
                    } else {
                      store.updateCarga(Carga(
                        id: carga.id,
                        descricao: descCtrl.text,
                        pesoTotal: double.parse(pesoCtrl.text),
                        origem: origemCtrl.text,
                        destino: destinoCtrl.text,
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
    );
  }

  /// Retorna a cor do status para destaque visual na lista.
  Color _corStatus(String status) {
    switch (status) {
      case 'Em transporte':
        return Colors.orange;
      case 'Entregue':
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  /// Renderiza a lista de cargas e as ações de manutenção.
  Widget build(BuildContext context) {
    final store = context.watch<DataStore>();
    return Scaffold(
      appBar: AppBar(title: const Text('Cargas')),
      // lista as cargas ou avisa se nao houver
      body: store.cargas.isEmpty
          ? const Center(child: Text('Nenhuma carga cadastrada.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: store.cargas.length,
              itemBuilder: (context, i) {
                final c = store.cargas[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _corStatus(c.status),
                      child: const Icon(Icons.local_shipping, color: Colors.white),
                    ),
                    title: Text(c.descricao),
                    subtitle: Text('${c.origem} → ${c.destino}\n${c.pesoTotal} kg • ${c.status}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // botoes de edicao e exclusao
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _abrirFormulario(context, carga: c),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => store.deleteCarga(c.id),
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
