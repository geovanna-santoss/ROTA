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
    Produto(id: 'p4', nome: 'Arroz Branco', quantidade: 50, peso: 5.0, categoria: 'Alimentício'),
    Produto(id: 'p5', nome: 'Feijão Preto', quantidade: 30, peso: 1.0, categoria: 'Alimentício'),
    Produto(id: 'p6', nome: 'Açúcar Refinado', quantidade: 40, peso: 5.0, categoria: 'Alimentício'),
    Produto(id: 'p7', nome: 'Café em Pó', quantidade: 20, peso: 0.5, categoria: 'Alimentício'),
    Produto(id: 'p8', nome: 'Leite em Pó', quantidade: 25, peso: 0.4, categoria: 'Alimentício'),
    Produto(id: 'p9', nome: 'Óleo de Soja', quantidade: 60, peso: 0.9, categoria: 'Alimentício'),
    Produto(id: 'p10', nome: 'Macarrão Espaguete', quantidade: 35, peso: 0.5, categoria: 'Alimentício'),
    Produto(id: 'p11', nome: 'Farinha de Trigo', quantidade: 45, peso: 5.0, categoria: 'Alimentício'),
    Produto(id: 'p12', nome: 'Sal Refinado', quantidade: 30, peso: 1.0, categoria: 'Alimentício'),
    Produto(id: 'p13', nome: 'Molho de Tomate', quantidade: 50, peso: 0.34, categoria: 'Alimentício'),
    Produto(id: 'p14', nome: 'Sabão em Pó', quantidade: 20, peso: 1.5, categoria: 'Limpeza'),
    Produto(id: 'p15', nome: 'Detergente Líquido', quantidade: 40, peso: 0.5, categoria: 'Limpeza'),
    Produto(id: 'p16', nome: 'Água Sanitária', quantidade: 30, peso: 2.0, categoria: 'Limpeza'),
    Produto(id: 'p17', nome: 'Desinfetante', quantidade: 25, peso: 1.0, categoria: 'Limpeza'),
    Produto(id: 'p18', nome: 'Esponja de Aço', quantidade: 100, peso: 0.02, categoria: 'Limpeza'),
    Produto(id: 'p19', nome: 'Papel Toalha', quantidade: 80, peso: 0.2, categoria: 'Limpeza'),
    Produto(id: 'p20', nome: 'Saco de Lixo', quantidade: 60, peso: 0.1, categoria: 'Limpeza'),
    Produto(id: 'p21', nome: 'Shampoo', quantidade: 30, peso: 0.35, categoria: 'Higiene Pessoal'),
    Produto(id: 'p22', nome: 'Condicionador', quantidade: 25, peso: 0.35, categoria: 'Higiene Pessoal'),
    Produto(id: 'p23', nome: 'Sabonete Líquido', quantidade: 40, peso: 0.25, categoria: 'Higiene Pessoal'),
    Produto(id: 'p24', nome: 'Creme Dental', quantidade: 50, peso: 0.09, categoria: 'Higiene Pessoal'),
    Produto(id: 'p25', nome: 'Desodorante Aerosol', quantidade: 35, peso: 0.15, categoria: 'Higiene Pessoal'),
    Produto(id: 'p26', nome: 'Fralda Descartável', quantidade: 60, peso: 0.12, categoria: 'Higiene Pessoal'),
    Produto(id: 'p27', nome: 'Papel Higiênico', quantidade: 100, peso: 0.3, categoria: 'Higiene Pessoal'),
    Produto(id: 'p28', nome: 'Pilhas AA', quantidade: 80, peso: 0.024, categoria: 'Eletrônicos'),
    Produto(id: 'p29', nome: 'Lâmpada LED', quantidade: 40, peso: 0.05, categoria: 'Eletrônicos'),
    Produto(id: 'p30', nome: 'Fio Elétrico (10m)', quantidade: 15, peso: 0.5, categoria: 'Eletrônicos'),
    Produto(id: 'p31', nome: 'Carregador USB', quantidade: 25, peso: 0.06, categoria: 'Eletrônicos'),
    Produto(id: 'p32', nome: 'Fone de Ouvido', quantidade: 20, peso: 0.04, categoria: 'Eletrônicos'),
    Produto(id: 'p33', nome: 'Caneta Esferográfica', quantidade: 200, peso: 0.01, categoria: 'Papelaria'),
    Produto(id: 'p34', nome: 'Caderno Universitário', quantidade: 50, peso: 0.4, categoria: 'Papelaria'),
    Produto(id: 'p35', nome: 'Grampeador', quantidade: 15, peso: 0.15, categoria: 'Papelaria'),
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
    Motorista(id: 'm1', nome: 'João Carlos Silva', cnh: '12345678901', telefone: '(11) 91234-5678', disponivel: true),
    Motorista(id: 'm2', nome: 'Maria Aparecida Santos', cnh: '23456789012', telefone: '(11) 92345-6789', disponivel: false),
    Motorista(id: 'm3', nome: 'José Roberto Almeida', cnh: '34567890123', telefone: '(21) 93456-7890', disponivel: true),
    Motorista(id: 'm4', nome: 'Ana Paula Ferreira', cnh: '45678901234', telefone: '(31) 94567-8901', disponivel: true),
    Motorista(id: 'm5', nome: 'Carlos Eduardo Lima', cnh: '56789012345', telefone: '(41) 95678-9012', disponivel: false),
    Motorista(id: 'm6', nome: 'Fernanda Cristina Rocha', cnh: '67890123456', telefone: '(51) 96789-0123', disponivel: true),
    Motorista(id: 'm7', nome: 'Ricardo José Martins', cnh: '78901234567', telefone: '(61) 97890-1234', disponivel: true),
    Motorista(id: 'm8', nome: 'Patrícia Helena Gomes', cnh: '89012345678', telefone: '(71) 98901-2345', disponivel: false),
    Motorista(id: 'm9', nome: 'Roberto Carlos Nunes', cnh: '90123456789', telefone: '(81) 99012-3456', disponivel: true),
    Motorista(id: 'm10', nome: 'Sandra Regina Oliveira', cnh: '01234567890', telefone: '(91) 90123-4567', disponivel: true),
    Motorista(id: 'm11', nome: 'Marcos Vinícius Pereira', cnh: '11223344556', telefone: '(11) 98765-4321', disponivel: false),
    Motorista(id: 'm12', nome: 'Juliana Costa Alves', cnh: '22334455667', telefone: '(21) 97654-3210', disponivel: true),
    Motorista(id: 'm13', nome: 'Anderson Luiz Barbosa', cnh: '33445566778', telefone: '(31) 96543-2109', disponivel: true),
    Motorista(id: 'm14', nome: 'Renata Maria Silva', cnh: '44556677889', telefone: '(41) 95432-1098', disponivel: false),
    Motorista(id: 'm15', nome: 'Fabiano Souza Santos', cnh: '55667788990', telefone: '(51) 94321-0987', disponivel: true),
    Motorista(id: 'm16', nome: 'Tatiane Oliveira Campos', cnh: '66778899001', telefone: '(61) 93210-9876', disponivel: true),
    Motorista(id: 'm17', nome: 'Eduardo Henrique Dias', cnh: '77889900112', telefone: '(71) 92109-8765', disponivel: false),
    Motorista(id: 'm18', nome: 'Camila Ferreira Lima', cnh: '88990011223', telefone: '(81) 91098-7654', disponivel: true),
    Motorista(id: 'm19', nome: 'Gustavo Henrique Rocha', cnh: '99001122334', telefone: '(91) 90987-6543', disponivel: true),
    Motorista(id: 'm20', nome: 'Vanessa Cristina Souza', cnh: '10112233445', telefone: '(11) 89876-5432', disponivel: false),
    Motorista(id: 'm21', nome: 'Marcelo Augusto Santos', cnh: '11223344556', telefone: '(21) 88765-4321', disponivel: true),
    Motorista(id: 'm22', nome: 'Letícia Alves Pereira', cnh: '22334455667', telefone: '(31) 87654-3210', disponivel: true),
    Motorista(id: 'm23', nome: 'Thiago Gabriel Oliveira', cnh: '33445566778', telefone: '(41) 86543-2109', disponivel: false),
    Motorista(id: 'm24', nome: 'Bruna Letícia Martins', cnh: '44556677889', telefone: '(51) 85432-1098', disponivel: true),
    Motorista(id: 'm25', nome: 'Rafael Augusto Lima', cnh: '55667788990', telefone: '(61) 84321-0987', disponivel: true),
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
    Veiculo(id: 'v1', placa: 'ABC-1234', modelo: 'Mercedes-Benz Actros 2644 (Caminhão)', capacidadeKg: 28000, disponivel: true),
    Veiculo(id: 'v2', placa: 'DEF-5678', modelo: 'Scania R 450 (Caminhão)', capacidadeKg: 32000, disponivel: false),
    Veiculo(id: 'v3', placa: 'GHI-9012', modelo: 'Volkswagen 24.280 (Caminhão)', capacidadeKg: 24000, disponivel: true),
    Veiculo(id: 'v4', placa: 'JKL-3456', modelo: 'Ford Cargo 2626E (Caminhão)', capacidadeKg: 26000, disponivel: true),
    Veiculo(id: 'v5', placa: 'MNO-7890', modelo: 'Iveco Tector 27T (Caminhão)', capacidadeKg: 27000, disponivel: false),
    Veiculo(id: 'v6', placa: 'PQR-1234', modelo: 'DAF XF 530 (Caminhão)', capacidadeKg: 35000, disponivel: true),
    Veiculo(id: 'v7', placa: 'STU-5678', modelo: 'MAN TGX 26.440 (Caminhão)', capacidadeKg: 30000, disponivel: true),
    Veiculo(id: 'v8', placa: 'VWX-9012', modelo: 'Volvo FH 460 (Caminhão)', capacidadeKg: 34000, disponivel: false),
    Veiculo(id: 'v9', placa: 'YZA-3456', modelo: 'Scania R 500 V8 (Caminhão)', capacidadeKg: 33000, disponivel: true),
    Veiculo(id: 'v10', placa: 'BCD-7890', modelo: 'Mercedes-Benz Axor 2533 (Caminhão)', capacidadeKg: 25000, disponivel: true),
    Veiculo(id: 'v11', placa: 'EFG-1234', modelo: 'Volkswagen Constellation 31.280 (Caminhão)', capacidadeKg: 31000, disponivel: false),
    Veiculo(id: 'v12', placa: 'HIJ-5678', modelo: 'Ford Cargo 2620 (Caminhão)', capacidadeKg: 26000, disponivel: true),
    Veiculo(id: 'v13', placa: 'KLM-9012', modelo: 'Iveco Stralis 440S (Caminhão)', capacidadeKg: 29000, disponivel: true),
    Veiculo(id: 'v14', placa: 'NOP-3456', modelo: 'Rodotrem 9 eixos (Carreta)', capacidadeKg: 74000, disponivel: false),
    Veiculo(id: 'v15', placa: 'QRS-7890', modelo: 'Bitrem 7 eixos (Carreta)', capacidadeKg: 57000, disponivel: true),
    Veiculo(id: 'v16', placa: 'TUV-1234', modelo: 'Carreta LS 3 eixos (Carreta)', capacidadeKg: 42000, disponivel: true),
    Veiculo(id: 'v17', placa: 'WXY-5678', modelo: 'Carreta SR 2 eixos (Carreta)', capacidadeKg: 32000, disponivel: false),
    Veiculo(id: 'v18', placa: 'ZAB-9012', modelo: 'Rodotrem 7 eixos (Carreta)', capacidadeKg: 62000, disponivel: true),
    Veiculo(id: 'v19', placa: 'CDE-3456', modelo: 'Bitrem 6 eixos (Carreta)', capacidadeKg: 48000, disponivel: true),
    Veiculo(id: 'v20', placa: 'FGH-7890', modelo: 'Carreta graneleira 3 eixos (Carreta)', capacidadeKg: 45000, disponivel: false),
    Veiculo(id: 'v21', placa: 'IJK-1234', modelo: 'Carreta baú 2 eixos (Carreta)', capacidadeKg: 28000, disponivel: true),
    Veiculo(id: 'v22', placa: 'LMO-5678', modelo: 'Carreta frigorífica 3 eixos (Carreta)', capacidadeKg: 35000, disponivel: true),
    Veiculo(id: 'v23', placa: 'NPR-9012', modelo: 'Rodotrem frigorífico (Carreta)', capacidadeKg: 55000, disponivel: false),
    Veiculo(id: 'v24', placa: 'QST-3456', modelo: 'Carreta tanque 3 eixos (Carreta)', capacidadeKg: 40000, disponivel: true),
    Veiculo(id: 'v25', placa: 'UVW-7890', modelo: 'Toyota Hilux SRX 4x4 (Caminhonete)', capacidadeKg: 1200, disponivel: true),
    Veiculo(id: 'v26', placa: 'XYZ-1234', modelo: 'Ford Ranger Limited (Caminhonete)', capacidadeKg: 1100, disponivel: false),
    Veiculo(id: 'v27', placa: 'ABC-5678', modelo: 'Chevrolet S10 High Country (Caminhonete)', capacidadeKg: 1150, disponivel: true),
    Veiculo(id: 'v28', placa: 'DEF-9012', modelo: 'Ram 2500 Laramie (Caminhonete)', capacidadeKg: 2500, disponivel: true),
    Veiculo(id: 'v29', placa: 'GHI-3456', modelo: 'Toyota Hilux SW4 (Caminhonete)', capacidadeKg: 1000, disponivel: false),
    Veiculo(id: 'v30', placa: 'JKL-7890', modelo: 'Mitsubishi L200 Triton (Caminhonete)', capacidadeKg: 1080, disponivel: true),
    Veiculo(id: 'v31', placa: 'MNO-1234', modelo: 'Nissan Frontier PRO-4X (Caminhonete)', capacidadeKg: 1050, disponivel: true),
    Veiculo(id: 'v32', placa: 'PQR-5678', modelo: 'Ford Maverick XLT (Caminhonete)', capacidadeKg: 950, disponivel: false),
    Veiculo(id: 'v33', placa: 'STU-9012', modelo: 'Fiat Toro Freedom (Caminhonete)', capacidadeKg: 750, disponivel: true),
    Veiculo(id: 'v34', placa: 'VWX-3456', modelo: 'Renault Duster Oroch (Caminhonete)', capacidadeKg: 680, disponivel: true),
    Veiculo(id: 'v35', placa: 'YZA-7890', modelo: 'Mercedes-Benz Sprinter 416 (Van)', capacidadeKg: 2500, disponivel: false),
    Veiculo(id: 'v36', placa: 'BCD-1234', modelo: 'Ford Transit 350 (Van)', capacidadeKg: 2300, disponivel: true),
    Veiculo(id: 'v37', placa: 'EFG-5678', modelo: 'Iveco Daily 50C17 (Van)', capacidadeKg: 2800, disponivel: true),
    Veiculo(id: 'v38', placa: 'HIJ-9012', modelo: 'Volkswagen Delivery 8.180 (Van)', capacidadeKg: 2100, disponivel: false),
    Veiculo(id: 'v39', placa: 'KLM-3456', modelo: 'Mercedes-Benz Sprinter 515 (Van)', capacidadeKg: 2600, disponivel: true),
    Veiculo(id: 'v40', placa: 'NOP-7890', modelo: 'Renault Master 160 (Van)', capacidadeKg: 1800, disponivel: true),
    Veiculo(id: 'v41', placa: 'QRS-1234', modelo: 'Fiat Ducato 35S (Van)', capacidadeKg: 2000, disponivel: false),
    Veiculo(id: 'v42', placa: 'TUV-5678', modelo: 'Citroën Jumper 35 (Van)', capacidadeKg: 2200, disponivel: true),
    Veiculo(id: 'v43', placa: 'WXY-9012', modelo: 'Peugeot Boxer 335 (Van)', capacidadeKg: 2150, disponivel: true),
    Veiculo(id: 'v44', placa: 'ZAB-3456', modelo: 'Ford Transit 320 (Van)', capacidadeKg: 1900, disponivel: false),
    Veiculo(id: 'v45', placa: 'CDE-7890', modelo: 'Chevrolet Express 3500 (Van)', capacidadeKg: 2400, disponivel: true),
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
    Carga(id: 'c1', descricao: 'Eletrônicos - Lotes de celulares', origem: 'São Paulo - SP', destino: 'Manaus - AM', pesoTotal: 1200, status: 'Entregue'),
    Carga(id: 'c2', descricao: 'Grãos de soja', origem: 'Sorriso - MT', destino: 'Santos - SP', pesoTotal: 28000, status: 'Pendente'),
    Carga(id: 'c3', descricao: 'Medicamentos hospitalares', origem: 'Rio de Janeiro - RJ', destino: 'Brasília - DF', pesoTotal: 850, status: 'Entregue'),
    Carga(id: 'c4', descricao: 'Móveis planejados', origem: 'Curitiba - PR', destino: 'Porto Alegre - RS', pesoTotal: 3200, status: 'Não entregue'),
    Carga(id: 'c5', descricao: 'Produtos de limpeza', origem: 'São Paulo - SP', destino: 'Belo Horizonte - MG', pesoTotal: 4500, status: 'Entregue'),
    Carga(id: 'c6', descricao: 'Peças automotivas', origem: 'São Bernardo - SP', destino: 'Goiânia - GO', pesoTotal: 1800, status: 'Pendente'),
    Carga(id: 'c7', descricao: 'Roupas e tecidos', origem: 'Fortaleza - CE', destino: 'Salvador - BA', pesoTotal: 2200, status: 'Entregue'),
    Carga(id: 'c8', descricao: 'Alimentos perecíveis (frutas)', origem: 'Petrolina - PE', destino: 'Recife - PE', pesoTotal: 3500, status: 'Pendente'),
    Carga(id: 'c9', descricao: 'Materiais de construção (cimento)', origem: 'Rio de Janeiro - RJ', destino: 'Vitória - ES', pesoTotal: 25000, status: 'Entregue'),
    Carga(id: 'c10', descricao: 'Livros e papelaria', origem: 'São Paulo - SP', destino: 'Curitiba - PR', pesoTotal: 950, status: 'Entregue'),
    Carga(id: 'c11', descricao: 'Produtos químicos industriais', origem: 'Cubatão - SP', destino: 'Campinas - SP', pesoTotal: 4200, status: 'Não entregue'),
    Carga(id: 'c12', descricao: 'Bebidas engarrafadas', origem: 'Petrópolis - RJ', destino: 'Niterói - RJ', pesoTotal: 3100, status: 'Entregue'),
    Carga(id: 'c13', descricao: 'Pneus e borrachas', origem: 'Santo André - SP', destino: 'Ribeirão Preto - SP', pesoTotal: 2700, status: 'Pendente'),
    Carga(id: 'c14', descricao: 'Equipamentos hospitalares', origem: 'São Paulo - SP', destino: 'Florianópolis - SC', pesoTotal: 1450, status: 'Entregue'),
    Carga(id: 'c15', descricao: 'Fertilizantes agrícolas', origem: 'Uberaba - MG', destino: 'Campo Grande - MS', pesoTotal: 32000, status: 'Pendente'),
    Carga(id: 'c16', descricao: 'Materiais elétricos (cabos)', origem: 'Osasco - SP', destino: 'Porto Alegre - RS', pesoTotal: 1900, status: 'Entregue'),
    Carga(id: 'c17', descricao: 'Plásticos e derivados', origem: 'Caxias do Sul - RS', destino: 'Joinville - SC', pesoTotal: 2800, status: 'Não entregue'),
    Carga(id: 'c18', descricao: 'Produtos de higiene pessoal', origem: 'São Paulo - SP', destino: 'Recife - PE', pesoTotal: 2100, status: 'Entregue'),
    Carga(id: 'c19', descricao: 'Peças de reposição para máquinas', origem: 'Contagem - MG', destino: 'Salvador - BA', pesoTotal: 1650, status: 'Pendente'),
    Carga(id: 'c20', descricao: 'Material esportivo', origem: 'São Paulo - SP', destino: 'Rio de Janeiro - RJ', pesoTotal: 800, status: 'Entregue'),
    Carga(id: 'c21', descricao: 'Suplementos alimentares', origem: 'Curitiba - PR', destino: 'Brasília - DF', pesoTotal: 1200, status: 'Entregue'),
    Carga(id: 'c22', descricao: 'Cosméticos e perfumes', origem: 'São Paulo - SP', destino: 'Fortaleza - CE', pesoTotal: 900, status: 'Pendente'),
    Carga(id: 'c23', descricao: 'Laticínios (queijos)', origem: 'Minas Gerais - MG', destino: 'Rio de Janeiro - RJ', pesoTotal: 2600, status: 'Entregue'),
    Carga(id: 'c24', descricao: 'Grãos de café', origem: 'Patrocínio - MG', destino: 'Santos - SP', pesoTotal: 18000, status: 'Entregue'),
    Carga(id: 'c25', descricao: 'Ferramentas agrícolas', origem: 'Ribeirão Preto - SP', destino: 'Cuiabá - MT', pesoTotal: 2300, status: 'Não entregue'),
    Carga(id: 'c26', descricao: 'Artigos de decoração', origem: 'São Paulo - SP', destino: 'Gramado - RS', pesoTotal: 750, status: 'Entregue'),
    Carga(id: 'c27', descricao: 'Inflamáveis e combustíveis', origem: 'Rio de Janeiro - RJ', destino: 'Santos - SP', pesoTotal: 15000, status: 'Pendente'),
    Carga(id: 'c28', descricao: 'Equipamentos de informática', origem: 'São Paulo - SP', destino: 'Belém - PA', pesoTotal: 1100, status: 'Entregue'),
    Carga(id: 'c29', descricao: 'Tecidos e aviamentos', origem: 'Blumenau - SC', destino: 'São Paulo - SP', pesoTotal: 1950, status: 'Entregue'),
    Carga(id: 'c30', descricao: 'Doces e conservas', origem: 'Pelotas - RS', destino: 'Porto Alegre - RS', pesoTotal: 1400, status: 'Pendente'),
    Carga(id: 'c31', descricao: 'Produtos de vidro', origem: 'São Paulo - SP', destino: 'Curitiba - PR', pesoTotal: 2100, status: 'Não entregue'),
    Carga(id: 'c32', descricao: 'Materiais odontológicos', origem: 'São Paulo - SP', destino: 'Salvador - BA', pesoTotal: 580, status: 'Entregue'),
    Carga(id: 'c33', descricao: 'Tubos e conexões PVC', origem: 'Caxias do Sul - RS', destino: 'Florianópolis - SC', pesoTotal: 3200, status: 'Entregue'),
    Carga(id: 'c34', descricao: 'Grãos de milho', origem: 'Campo Mourão - PR', destino: 'Paranaguá - PR', pesoTotal: 30000, status: 'Pendente'),
    Carga(id: 'c35', descricao: 'Produtos de couro', origem: 'Novo Hamburgo - RS', destino: 'São Paulo - SP', pesoTotal: 1700, status: 'Entregue'),
    Carga(id: 'c36', descricao: 'Brinquedos educativos', origem: 'Manaus - AM', destino: 'Rio de Janeiro - RJ', pesoTotal: 980, status: 'Entregue'),
    Carga(id: 'c37', descricao: 'Ferro e aço', origem: 'Volta Redonda - RJ', destino: 'Salvador - BA', pesoTotal: 35000, status: 'Pendente'),
    Carga(id: 'c38', descricao: 'Artigos de pesca', origem: 'Itajaí - SC', destino: 'Santos - SP', pesoTotal: 1200, status: 'Entregue'),
    Carga(id: 'c39', descricao: 'Peças de bicicleta', origem: 'São Paulo - SP', destino: 'Curitiba - PR', pesoTotal: 650, status: 'Não entregue'),
    Carga(id: 'c40', descricao: 'Medicamentos veterinários', origem: 'Campinas - SP', destino: 'Goiânia - GO', pesoTotal: 780, status: 'Entregue'),
    Carga(id: 'c41', descricao: 'Materiais isolantes térmicos', origem: 'São Paulo - SP', destino: 'Manaus - AM', pesoTotal: 1600, status: 'Pendente'),
    Carga(id: 'c42', descricao: 'Cervejas artesanais', origem: 'Petrópolis - RJ', destino: 'Brasília - DF', pesoTotal: 2400, status: 'Entregue'),
    Carga(id: 'c43', descricao: 'Equipamentos de academia', origem: 'São Paulo - SP', destino: 'Curitiba - PR', pesoTotal: 3100, status: 'Entregue'),
    Carga(id: 'c44', descricao: 'Produtos de papel reciclado', origem: 'São Paulo - SP', destino: 'Recife - PE', pesoTotal: 1850, status: 'Pendente'),
    Carga(id: 'c45', descricao: 'Ferragens e parafusos', origem: 'Joinville - SC', destino: 'Porto Alegre - RS', pesoTotal: 2700, status: 'Entregue'),
    Carga(id: 'c46', descricao: 'Produtos de jardinagem', origem: 'Holambra - SP', destino: 'Belo Horizonte - MG', pesoTotal: 1300, status: 'Entregue'),
    Carga(id: 'c47', descricao: 'Camisetas e uniformes', origem: 'São Paulo - SP', destino: 'Salvador - BA', pesoTotal: 1100, status: 'Não entregue'),
    Carga(id: 'c48', descricao: 'Material de camping', origem: 'São Paulo - SP', destino: 'Gramado - RS', pesoTotal: 860, status: 'Entregue'),
    Carga(id: 'c49', descricao: 'Alimentos congelados', origem: 'São Paulo - SP', destino: 'Cuiabá - MT', pesoTotal: 4200, status: 'Pendente'),
    Carga(id: 'c50', descricao: 'Fios têxteis', origem: 'Americana - SP', destino: 'Fortaleza - CE', pesoTotal: 2050, status: 'Entregue'),
    Carga(id: 'c51', descricao: 'Peças para tratores', origem: 'Ribeirão Preto - SP', destino: 'Campo Grande - MS', pesoTotal: 3800, status: 'Entregue'),
    Carga(id: 'c52', descricao: 'Medicamentos genéricos', origem: 'Rio de Janeiro - RJ', destino: 'Manaus - AM', pesoTotal: 920, status: 'Pendente'),
    Carga(id: 'c53', descricao: 'Esmaltes e vernizes', origem: 'São Paulo - SP', destino: 'Curitiba - PR', pesoTotal: 1450, status: 'Entregue'),
    Carga(id: 'c54', descricao: 'Carne bovina refrigerada', origem: 'Campo Grande - MS', destino: 'São Paulo - SP', pesoTotal: 5000, status: 'Entregue'),
    Carga(id: 'c55', descricao: 'Materiais fotográficos', origem: 'São Paulo - SP', destino: 'Rio de Janeiro - RJ', pesoTotal: 620, status: 'Não entregue'),
    Carga(id: 'c56', descricao: 'Produtos de cerâmica', origem: 'São Paulo - SP', destino: 'Brasília - DF', pesoTotal: 2700, status: 'Entregue'),
    Carga(id: 'c57', descricao: 'Equipamentos de som', origem: 'São Paulo - SP', destino: 'Salvador - BA', pesoTotal: 780, status: 'Pendente'),
    Carga(id: 'c58', descricao: 'Materiais impermeabilizantes', origem: 'São Paulo - SP', destino: 'Recife - PE', pesoTotal: 1900, status: 'Entregue'),
    Carga(id: 'c59', descricao: 'Farinha de milho', origem: 'Londrina - PR', destino: 'Curitiba - PR', pesoTotal: 22000, status: 'Entregue'),
    Carga(id: 'c60', descricao: 'Artigos de festa', origem: 'São Paulo - SP', destino: 'Belo Horizonte - MG', pesoTotal: 1100, status: 'Pendente'),
    Carga(id: 'c61', descricao: 'Lentes e armações de óculos', origem: 'São Paulo - SP', destino: 'Florianópolis - SC', pesoTotal: 420, status: 'Entregue'),
    Carga(id: 'c62', descricao: 'Produtos de marcenaria', origem: 'Curitiba - PR', destino: 'Porto Alegre - RS', pesoTotal: 2400, status: 'Entregue'),
    Carga(id: 'c63', descricao: 'Sementes agrícolas', origem: 'Uberlândia - MG', destino: 'Campo Grande - MS', pesoTotal: 2800, status: 'Não entregue'),
    Carga(id: 'c64', descricao: 'Luvas e EPIs', origem: 'São Paulo - SP', destino: 'Salvador - BA', pesoTotal: 970, status: 'Entregue'),
    Carga(id: 'c65', descricao: 'Artigos de couro (sapatos)', origem: 'Franca - SP', destino: 'Rio de Janeiro - RJ', pesoTotal: 1600, status: 'Pendente'),
    Carga(id: 'c66', descricao: 'Componentes eletrônicos', origem: 'Campinas - SP', destino: 'Manaus - AM', pesoTotal: 730, status: 'Entregue'),
    Carga(id: 'c67', descricao: 'Gesso e forros', origem: 'São Paulo - SP', destino: 'Curitiba - PR', pesoTotal: 4100, status: 'Entregue'),
    Carga(id: 'c68', descricao: 'Produtos de limpeza hospitalar', origem: 'São Paulo - SP', destino: 'Brasília - DF', pesoTotal: 2600, status: 'Pendente'),
    Carga(id: 'c69', descricao: 'Ração animal', origem: 'São Paulo - SP', destino: 'Goiânia - GO', pesoTotal: 4500, status: 'Entregue'),
    Carga(id: 'c70', descricao: 'Bebidas energéticas', origem: 'São Paulo - SP', destino: 'Recife - PE', pesoTotal: 1700, status: 'Entregue'),
    Carga(id: 'c71', descricao: 'Materiais para serigrafia', origem: 'São Paulo - SP', destino: 'Porto Alegre - RS', pesoTotal: 890, status: 'Não entregue'),
    Carga(id: 'c72', descricao: 'Peças para motocicletas', origem: 'São Paulo - SP', destino: 'Cuiabá - MT', pesoTotal: 2100, status: 'Entregue'),
    Carga(id: 'c73', descricao: 'Produtos ortopédicos', origem: 'Rio de Janeiro - RJ', destino: 'Salvador - BA', pesoTotal: 650, status: 'Pendente'),
    Carga(id: 'c74', descricao: 'Alimentos orgânicos', origem: 'São Paulo - SP', destino: 'Curitiba - PR', pesoTotal: 3200, status: 'Entregue'),
    Carga(id: 'c75', descricao: 'Tintas e corantes', origem: 'São Paulo - SP', destino: 'Manaus - AM', pesoTotal: 3800, status: 'Entregue'),
    Carga(id: 'c76', descricao: 'Instrumentos musicais', origem: 'São Paulo - SP', destino: 'Rio de Janeiro - RJ', pesoTotal: 560, status: 'Pendente'),
    Carga(id: 'c77', descricao: 'Materiais de PTFE (teflon)', origem: 'São Paulo - SP', destino: 'Florianópolis - SC', pesoTotal: 1400, status: 'Entregue'),
    Carga(id: 'c78', descricao: 'Shampoo profissional', origem: 'São Paulo - SP', destino: 'Belo Horizonte - MG', pesoTotal: 1050, status: 'Entregue'),
    Carga(id: 'c79', descricao: 'Produtos de silicone', origem: 'São Paulo - SP', destino: 'Curitiba - PR', pesoTotal: 1200, status: 'Não entregue'),
    Carga(id: 'c80', descricao: 'Chocolates e balas', origem: 'São Paulo - SP', destino: 'Salvador - BA', pesoTotal: 1900, status: 'Entregue'),
    Carga(id: 'c81', descricao: 'Materiais para impressão 3D', origem: 'São Paulo - SP', destino: 'Brasília - DF', pesoTotal: 430, status: 'Pendente'),
    Carga(id: 'c82', descricao: 'Produtos de arquearia', origem: 'São Paulo - SP', destino: 'Porto Alegre - RS', pesoTotal: 720, status: 'Entregue'),
    Carga(id: 'c83', descricao: 'Artigos de luxo (joias)', origem: 'São Paulo - SP', destino: 'Rio de Janeiro - RJ', pesoTotal: 280, status: 'Entregue'),
    Carga(id: 'c84', descricao: 'Componentes aeroespaciais', origem: 'São José dos Campos', destino: 'Brasília - DF', pesoTotal: 1500, status: 'Pendente'),
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
