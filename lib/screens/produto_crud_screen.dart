import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_store.dart';
import '../models/produto.dart';

/// Tela para criar, listar, editar e excluir produtos.
class ProdutoCrudScreen extends StatelessWidget {
  const ProdutoCrudScreen({super.key});

  /// Abre o formulário para criação ou edição de produto.
  void _abrirFormulario(BuildContext context, {Produto? produto}) {
    final nomeCtrl = TextEditingController(text: produto?.nome ?? '');
    final qtdCtrl = TextEditingController(text: produto?.quantidade.toString() ?? '');
    final pesoCtrl = TextEditingController(text: produto?.peso.toString() ?? '');
    final catCtrl = TextEditingController(text: produto?.categoria ?? '');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
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
              Text(produto == null ? 'Novo Produto' : 'Editar Produto',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              // campos de texto para os dados do produto
              TextFormField(
                controller: nomeCtrl,
                decoration: const InputDecoration(labelText: 'Nome do produto'),
                validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
              ),
              TextFormField(
                controller: catCtrl,
                decoration: const InputDecoration(labelText: 'Categoria'),
                validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
              ),
              TextFormField(
                controller: qtdCtrl,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (v) => (int.tryParse(v ?? '') == null) ? 'Número inválido' : null,
              ),
              TextFormField(
                controller: pesoCtrl,
                decoration: const InputDecoration(labelText: 'Peso unitário (kg)'),
                keyboardType: TextInputType.number,
                validator: (v) => (double.tryParse(v ?? '') == null) ? 'Número inválido' : null,
              ),
              const SizedBox(height: 16),
              // botao para salvar as informacoes
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  final store = ctx.read<DataStore>();
                  if (produto == null) {
                    store.addProduto(Produto(
                      id: store.novoId('p'),
                      nome: nomeCtrl.text,
                      quantidade: int.parse(qtdCtrl.text),
                      peso: double.parse(pesoCtrl.text),
                      categoria: catCtrl.text,
                    ));
                  } else {
                    store.updateProduto(Produto(
                      id: produto.id,
                      nome: nomeCtrl.text,
                      quantidade: int.parse(qtdCtrl.text),
                      peso: double.parse(pesoCtrl.text),
                      categoria: catCtrl.text,
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
    );
  }

  @override
  /// Monta a lista de produtos com ações de edição e exclusão.
  Widget build(BuildContext context) {
    final store = context.watch<DataStore>();
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      // mostra a lista ou um aviso se estiver vazia
      body: store.produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: store.produtos.length,
              itemBuilder: (context, i) {
                final p = store.produtos[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.inventory_2),
                    title: Text(p.nome),
                    subtitle: Text('${p.categoria} • Qtd: ${p.quantidade} • ${p.peso} kg/un'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // botoes para editar e apagar
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _abrirFormulario(context, produto: p),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => store.deleteProduto(p.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      // botao flutuante para adicionar novo
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
