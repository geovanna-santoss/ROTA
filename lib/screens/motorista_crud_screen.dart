import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';
import '../models/motorista.dart';

/// Tela de CRUD de Motoristas
class MotoristaCrudScreen extends StatelessWidget {
  const MotoristaCrudScreen({super.key});

  void _abrirFormulario(BuildContext context, {Motorista? motorista}) {
    final nomeCtrl = TextEditingController(text: motorista?.nome ?? '');
    final cnhCtrl = TextEditingController(text: motorista?.cnh ?? '');
    final telCtrl = TextEditingController(text: motorista?.telefone ?? '');
    bool disponivel = motorista?.disponivel ?? true;
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
                Text(motorista == null ? 'Novo Motorista' : 'Editar Motorista',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nomeCtrl,
                  decoration: const InputDecoration(labelText: 'Nome completo'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                ),
                TextFormField(
                  controller: cnhCtrl,
                  decoration: const InputDecoration(labelText: 'CNH'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                ),
                TextFormField(
                  controller: telCtrl,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Disponível para rotas'),
                  value: disponivel,
                  onChanged: (v) => setStateModal(() => disponivel = v),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final store = ctx.read<DataStore>();
                    if (motorista == null) {
                      store.addMotorista(Motorista(
                        id: store.novoId('m'),
                        nome: nomeCtrl.text,
                        cnh: cnhCtrl.text,
                        telefone: telCtrl.text,
                        disponivel: disponivel,
                      ));
                    } else {
                      store.updateMotorista(Motorista(
                        id: motorista.id,
                        nome: nomeCtrl.text,
                        cnh: cnhCtrl.text,
                        telefone: telCtrl.text,
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
      appBar: AppBar(title: const Text('Motoristas')),
      body: store.motoristas.isEmpty
          ? const Center(child: Text('Nenhum motorista cadastrado.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: store.motoristas.length,
              itemBuilder: (context, i) {
                final m = store.motoristas[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: m.disponivel ? Colors.green : Colors.grey,
                      child: const Icon(Icons.badge, color: Colors.white),
                    ),
                    title: Text(m.nome),
                    subtitle: Text('CNH: ${m.cnh} • ${m.telefone}\n${m.disponivel ? "Disponível" : "Indisponível"}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _abrirFormulario(context, motorista: m),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => store.deleteMotorista(m.id),
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
