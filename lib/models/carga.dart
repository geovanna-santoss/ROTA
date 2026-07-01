/// Representa uma carga vinculada a uma operação de transporte.
class Carga {
  /// Identificador único da carga.
  String id;

  /// Descrição resumida da mercadoria.
  String descricao;

  /// Peso total da carga em quilogramas.
  double pesoTotal;

  /// Cidade ou ponto de origem da carga.
  String origem;

  /// Cidade ou ponto de destino da carga.
  String destino;

  /// Status logístico da carga: pendente, em transporte ou entregue.
  String status;

  /// Cria uma carga com status pendente como valor inicial.
  Carga({
    required this.id,
    required this.descricao,
    required this.pesoTotal,
    required this.origem,
    required this.destino,
    this.status = 'Pendente',
  });
}
