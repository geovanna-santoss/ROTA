// representa uma carga a ser transportada
class Carga {
  String id;
  String descricao;
  double pesoTotal;
  String origem;
  String destino;
  String status; // pendente, em transporte, entregue

  Carga({
    required this.id,
    required this.descricao,
    required this.pesoTotal,
    required this.origem,
    required this.destino,
    this.status = 'Pendente',
  });
}
