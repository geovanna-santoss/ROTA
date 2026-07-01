/// Armazena os dados de um motorista cadastrado no sistema.
class Motorista {
  /// Identificador único do motorista.
  String id;

  /// Nome completo do motorista.
  String nome;

  /// Número da habilitação (CNH).
  String cnh;

  /// Telefone de contato.
  String telefone;

  /// Indica se o motorista está disponível para uma rota.
  bool disponivel;

  /// Cria um motorista com disponibilidade ativa por padrão.
  Motorista({
    required this.id,
    required this.nome,
    required this.cnh,
    required this.telefone,
    this.disponivel = true,
  });
}
