/// Representa um produto controlado no estoque da operação.
class Produto {
  /// Identificador único do produto.
  String id;

  /// Nome comercial utilizado para exibição.
  String nome;

  /// Quantidade atual disponível no estoque.
  int quantidade;

  /// Peso unitário em quilogramas.
  double peso;

  /// Categoria usada em filtros e indicadores.
  String categoria;

  /// Cria uma instância de produto com todos os campos obrigatórios.
  Produto({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.peso,
    required this.categoria,
  });
}
