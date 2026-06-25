class Rota {
  String id;
  String origem;
  String destino;
  String motoristaId;
  String veiculoId;
  String cargaId;
  DateTime dataSaida;
  String status; // Planejada, Em andamento, Concluida

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
