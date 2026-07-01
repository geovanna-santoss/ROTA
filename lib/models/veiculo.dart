/// Define os dados de um veículo disponível para transporte.
class Veiculo {
  /// Identificador único do veículo.
  String id;

  /// Placa no padrão cadastrado pela empresa.
  String placa;

  /// Modelo do veículo para exibição e seleção.
  String modelo;

  /// Capacidade total de carga em quilogramas.
  double capacidadeKg;

  /// Indica se o veículo pode ser alocado em uma rota.
  bool disponivel;

  /// Cria um veículo com disponibilidade ativa por padrão.
  Veiculo({
    required this.id,
    required this.placa,
    required this.modelo,
    required this.capacidadeKg,
    this.disponivel = true,
  });
}
