/// Define o percurso planejado para uma entrega e seus vínculos.
class Rota {
  /// Identificador único da rota.
  String id;

  /// Local de partida da rota.
  String origem;

  /// Local de chegada da rota.
  String destino;

  /// ID do motorista responsável.
  String motoristaId;

  /// ID do veículo alocado.
  String veiculoId;

  /// ID da carga transportada.
  String cargaId;

  /// Data prevista de saída.
  DateTime dataSaida;

  /// Status operacional da rota: planejada, em andamento ou concluída.
  String status;

  /// Cria uma rota com status planejado como padrão.
  Rota({
    required this.id,
    required this.origem,
    required this.destino,
    required this.motoristaId,
    required this.veiculoId,
    required this.cargaId,
    required this.dataSaida,
    this.status = 'Planejada',
  });
}
