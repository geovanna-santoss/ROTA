class Veiculo {
  String id;
  String placa;
  String modelo;
  double capacidadeKg;
  bool disponivel;

  Veiculo({
    required this.id,
    required this.placa,
    required this.modelo,
    required this.capacidadeKg,
    this.disponivel = true,
  });
}
