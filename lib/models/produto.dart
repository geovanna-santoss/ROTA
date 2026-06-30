// informaçoes sobre o produto em estoque
class Produto {
  String id;
  String nome;
  int quantidade;
  double peso; // peso unitario em kg
  String categoria;

  Produto({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.peso,
    required this.categoria,
  });
}
