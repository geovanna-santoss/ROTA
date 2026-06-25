import 'package:flutter/foundation.dart';
import '../models/produto.dart';
import '../models/motorista.dart';
import '../models/veiculo.dart';
import '../models/carga.dart';
import '../models/rota.dart';

/// Armazena o estado da aplicação em memória e notifica os widgets
/// quando os dados mudam (CRUD completo para cada entidade).
/// Em uma evolução futura, esta camada pode ser substituída por
/// sqflite (banco local) ou por uma API REST (ver README - desafios).
class DataStore extends ChangeNotifier {
  // ----------------- AUTENTICAÇÃO -----------------
  String? usuarioLogado;

  bool login(String usuario, String senha) {
    // Autenticação simplificada para fins didáticos.
    // Usuário padrão: admin / senha: 1234
    if (usuario.trim().isNotEmpty && senha == '1234') {
      usuarioLogado = usuario;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    usuarioLogado = null;
    notifyListeners();
  }

  bool get estaLogado => usuarioLogado != null;

  // ----------------- PRODUTOS (ESTOQUE) -----------------
  final List<Produto> produtos = [
    Produto(id: 'p1', nome: 'Caixa de Eletrônicos', quantidade: 120, peso: 8.5, categoria: 'Eletrônicos'),
    Produto(id: 'p2', nome: 'Saco de Cimento', quantidade: 300, peso: 50, categoria: 'Construção'),
    Produto(id: 'p3', nome: 'Pallet de Bebidas', quantidade: 45, peso: 220, categoria: 'Alimentos'),
  ];

  void addProduto(Produto p) {
    produtos.add(p);
    notifyListeners();
  }

  void updateProduto(Produto p) {
    final i = produtos.indexWhere((e) => e.id == p.id);
    if (i != -1) produtos[i] = p;
    notifyListeners();
  }

  void deleteProduto(String id) {
    produtos.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // ----------------- MOTORISTAS -----------------
  final List<Motorista> motoristas = [
    Motorista(id: 'm1', nome: 'Carlos Souza', cnh: 'D-12345678', telefone: '(37) 99999-0001'),
    Motorista(id: 'm2', nome: 'Ana Pereira', cnh: 'E-87654321', telefone: '(37) 99999-0002'),
  ];

  void addMotorista(Motorista m) {
    motoristas.add(m);
    notifyListeners();
  }

  void updateMotorista(Motorista m) {
    final i = motoristas.indexWhere((e) => e.id == m.id);
    if (i != -1) motoristas[i] = m;
    notifyListeners();
  }

  void deleteMotorista(String id) {
    motoristas.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // ----------------- VEÍCULOS -----------------
  final List<Veiculo> veiculos = [
    Veiculo(id: 'v1', placa: 'ABC1D23', modelo: 'Caminhão Volvo FH', capacidadeKg: 15000),
    Veiculo(id: 'v2', placa: 'XYZ9E87', modelo: 'Van Sprinter', capacidadeKg: 1800),
  ];

  void addVeiculo(Veiculo v) {
    veiculos.add(v);
    notifyListeners();
  }

  void updateVeiculo(Veiculo v) {
    final i = veiculos.indexWhere((e) => e.id == v.id);
    if (i != -1) veiculos[i] = v;
    notifyListeners();
  }

  void deleteVeiculo(String id) {
    veiculos.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // ----------------- CARGAS -----------------
  final List<Carga> cargas = [
    Carga(id: 'c1', descricao: 'Eletrônicos - Loja Centro', pesoTotal: 980, origem: 'Formiga, MG', destino: 'Belo Horizonte, MG'),
    Carga(id: 'c2', descricao: 'Materiais de Construção', pesoTotal: 4500, origem: 'Divinópolis, MG', destino: 'Formiga, MG', status: 'Em transporte'),
  ];

  void addCarga(Carga c) {
    cargas.add(c);
    notifyListeners();
  }

  void updateCarga(Carga c) {
    final i = cargas.indexWhere((e) => e.id == c.id);
    if (i != -1) cargas[i] = c;
    notifyListeners();
  }

  void deleteCarga(String id) {
    cargas.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // ----------------- ROTAS -----------------
  final List<Rota> rotas = [];

  void addRota(Rota r) {
    rotas.add(r);
    notifyListeners();
  }

  void updateRota(Rota r) {
    final i = rotas.indexWhere((e) => e.id == r.id);
    if (i != -1) rotas[i] = r;
    notifyListeners();
  }

  void deleteRota(String id) {
    rotas.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // ----------------- INDICADORES -----------------
  int get totalProdutosEstoque =>
      produtos.fold(0, (soma, p) => soma + p.quantidade);

  int get rotasConcluidas => rotas.where((r) => r.status == 'Concluida').length;
  int get rotasEmAndamento => rotas.where((r) => r.status == 'Em andamento').length;
  int get rotasPlanejadas => rotas.where((r) => r.status == 'Planejada').length;

  Map<String, int> get produtosPorCategoria {
    final Map<String, int> mapa = {};
    for (final p in produtos) {
      mapa[p.categoria] = (mapa[p.categoria] ?? 0) + p.quantidade;
    }
    return mapa;
  }

  String _gerarId(String prefixo) =>
      '$prefixo${DateTime.now().microsecondsSinceEpoch}';

  String novoId(String prefixo) => _gerarId(prefixo);
}
