import 'package:flutter/foundation.dart';
import '../models/produto.dart';
import '../models/motorista.dart';
import '../models/veiculo.dart';
import '../models/carga.dart';
import '../models/rota.dart';

/// Centraliza os dados em memória da aplicação e notifica alterações de estado.
class DataStore extends ChangeNotifier {
  // guarda o nome do usuario que entrou no app
  String? usuarioLogado;

  /// Valida as credenciais e inicia a sessão local do usuário.
  bool login(String usuario, String senha) {
    if (usuario.trim().isNotEmpty && senha == '1234') {
      usuarioLogado = usuario;
      notifyListeners(); // avisa as telas para atualizar
      return true;
    }
    return false;
  }

  /// Encerra a sessão atual do usuário.
  void logout() {
    usuarioLogado = null;
    notifyListeners();
  }

  // diz se tem alguem logado no momento
  bool get estaLogado => usuarioLogado != null;

  // lista inicial de produtos no estoque
  final List<Produto> produtos = [
    Produto(id: 'p1', nome: 'Caixa de Eletrônicos', quantidade: 120, peso: 8.5, categoria: 'Eletrônicos'),
    Produto(id: 'p2', nome: 'Saco de Cimento', quantidade: 300, peso: 50, categoria: 'Construção'),
    Produto(id: 'p3', nome: 'Pallet de Bebidas', quantidade: 45, peso: 220, categoria: 'Alimentos'),
  ];

  // adiciona um novo produto na lista
  void addProduto(Produto p) {
    produtos.add(p);
    notifyListeners();
  }

  // atualiza os dados de um produto existente
  void updateProduto(Produto p) {
    final i = produtos.indexWhere((e) => e.id == p.id);
    if (i != -1) produtos[i] = p;
    notifyListeners();
  }

  // remove um produto da lista pelo id
  void deleteProduto(String id) {
    produtos.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // lista inicial de motoristas cadastrados
  final List<Motorista> motoristas = [
    Motorista(id: 'm1', nome: 'Carlos Souza', cnh: 'D-12345678', telefone: '(37) 99999-0001'),
    Motorista(id: 'm2', nome: 'Ana Pereira', cnh: 'E-87654321', telefone: '(37) 99999-0002'),
  ];

  // cadastra um novo motorista
  void addMotorista(Motorista m) {
    motoristas.add(m);
    notifyListeners();
  }

  // altera informacoes de um motorista
  void updateMotorista(Motorista m) {
    final i = motoristas.indexWhere((e) => e.id == m.id);
    if (i != -1) motoristas[i] = m;
    notifyListeners();
  }

  // exclui um motorista do sistema
  void deleteMotorista(String id) {
    motoristas.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // lista inicial de veiculos disponiveis
  final List<Veiculo> veiculos = [
    Veiculo(id: 'v1', placa: 'ABC1D23', modelo: 'Caminhão Volvo FH', capacidadeKg: 15000),
    Veiculo(id: 'v2', placa: 'XYZ9E87', modelo: 'Van Sprinter', capacidadeKg: 1800),
  ];

  // insere um novo veiculo
  void addVeiculo(Veiculo v) {
    veiculos.add(v);
    notifyListeners();
  }

  // atualiza dados de um veiculo
  void updateVeiculo(Veiculo v) {
    final i = veiculos.indexWhere((e) => e.id == v.id);
    if (i != -1) veiculos[i] = v;
    notifyListeners();
  }

  // remove um veiculo pelo id
  void deleteVeiculo(String id) {
    veiculos.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // lista de cargas cadastradas
  final List<Carga> cargas = [
    Carga(id: 'c1', descricao: 'Eletrônicos - Loja Centro', pesoTotal: 980, origem: 'Formiga, MG', destino: 'Belo Horizonte, MG'),
    Carga(id: 'c2', descricao: 'Materiais de Construção', pesoTotal: 4500, origem: 'Divinópolis, MG', destino: 'Formiga, MG', status: 'Em transporte'),
  ];

  // adiciona uma nova carga
  void addCarga(Carga c) {
    cargas.add(c);
    notifyListeners();
  }

  // atualiza o status ou dados da carga
  void updateCarga(Carga c) {
    final i = cargas.indexWhere((e) => e.id == c.id);
    if (i != -1) cargas[i] = c;
    notifyListeners();
  }

  // exclui uma carga
  void deleteCarga(String id) {
    cargas.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // lista que guarda as rotas criadas
  final List<Rota> rotas = [];

  // salva uma nova rota
  void addRota(Rota r) {
    rotas.add(r);
    notifyListeners();
  }

  // altera uma rota ja existente
  void updateRota(Rota r) {
    final i = rotas.indexWhere((e) => e.id == r.id);
    if (i != -1) rotas[i] = r;
    notifyListeners();
  }

  // apaga uma rota pelo id
  void deleteRota(String id) {
    rotas.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // soma a quantidade total de itens no estoque
  int get totalProdutosEstoque =>
      produtos.fold(0, (soma, p) => soma + p.quantidade);

  // conta quantas rotas estao concluidas
  int get rotasConcluidas => rotas.where((r) => r.status == 'Concluida').length;
  
  // conta as rotas que estao acontecendo agora
  int get rotasEmAndamento => rotas.where((r) => r.status == 'Em andamento').length;
  
  // conta as rotas que ainda vao comecar
  int get rotasPlanejadas => rotas.where((r) => r.status == 'Planejada').length;

  // agrupa a quantidade de produtos por tipo
  Map<String, int> get produtosPorCategoria {
    final Map<String, int> mapa = {};
    for (final p in produtos) {
      mapa[p.categoria] = (mapa[p.categoria] ?? 0) + p.quantidade;
    }
    return mapa;
  }

  // cria um id unico usando o tempo atual
  String _gerarId(String prefixo) =>
      '$prefixo${DateTime.now().microsecondsSinceEpoch}';

  /// Gera um novo ID público com prefixo por tipo de entidade.
  String novoId(String prefixo) => _gerarId(prefixo);
}
