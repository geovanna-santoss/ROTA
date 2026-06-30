// dados do motorista cadastrado
class Motorista {
  String id;
  String nome;
  String cnh;
  String telefone;
  bool disponivel;

  Motorista({
    required this.id,
    required this.nome,
    required this.cnh,
    required this.telefone,
    this.disponivel = true,
  });
}
