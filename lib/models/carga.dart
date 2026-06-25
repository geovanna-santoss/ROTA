class Carga {
  String id;
  String descricao;
  double pesoTotal;
  String origem;
  String destino;
  String status; // Pendente, Em transporte, Entregue

  Carga({
    required this.id,
    required this.descricao,
    required this.pesoTotal,
    required this.origem,
    required this.destino,
    this.status = 'Pendente',
  });
}
