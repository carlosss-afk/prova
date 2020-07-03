import 'package:cloud_firestore/cloud_firestore.dart';

import 'Produto.dart';

class Ordem {
  DateTime data;
  DateTime data_atendimento;
  DateTime data_cancelamento;
  DateTime data_final;
  String estado;
  String cliente;
  Produto produto;
  int quantidade;
  String razao;
  double valor;

  DocumentReference reference;

  Ordem({this.data, this.cliente, this.valor, this.estado});

  factory Ordem.fromMap(Map<String, dynamic> map) {
    return converteOrdem(map);
  }

  Map<String, dynamic> toMap() => _converteOrdemMap(this);

  factory Ordem.fromSnapshot(DocumentSnapshot snapshot) {
    Ordem ordem = Ordem.fromMap(snapshot.data);
    ordem.reference = snapshot.reference;
    return ordem;
  }
}

Ordem converteOrdem(Map<String, dynamic> map) {
  Ordem ordem = Ordem();

  if (map['data'] != null)
    ordem.data = map['data'].toDate();
  else
    ordem.data = DateTime.parse("0000-00-00 00:00:00");

  if (map['data_atendimento'] != null)
    ordem.data_atendimento = map['data_atendimento'].toDate();
  else
    ordem.data_atendimento = DateTime.parse("0000-00-00 00:00:00");

  if (map['data_cancelamento'] != null)
    ordem.data_cancelamento = map['data_cancelamento'].toDate();
  else
    ordem.data_cancelamento = DateTime.parse("0000-00-00 00:00:00");

  if (map['data_final'] != null)
    ordem.data_final = map['data_final'].toDate();
  else
    ordem.data_final = DateTime.parse("0000-00-00 00:00:00");

  if (map['estado'] != null)
    ordem.estado = map['estado'];
  else
    ordem.estado = 'Pendente';

  if (map['nome_cliente'] != null)
    ordem.cliente = map['nome_cliente'];
  else
    ordem.cliente = null;

  if (map['produto'] != null)
    converteProduto(map['produto'] as DocumentReference)
        .then((produto) => ordem.produto = produto);
  else
    ordem.produto = null;

  if (map['quantidade'] != null)
    ordem.quantidade = map['quantidade'];
  else
    ordem.quantidade = 0;

  if (map['razao'] != null)
    ordem.razao = map['razao'];
  else
    ordem.razao = 'Sem razão';

  if (map['valor'] != null)
    ordem.valor = map['valor'].toDouble();
  else
    ordem.valor = 0.00;

  return ordem;
}

Future<Produto> converteProduto(DocumentReference produto) async {
  if (produto == null) return null;

  DocumentSnapshot snapshot = await produto.get();

  return Produto.fromSnapshot(snapshot);
}

Map<String, dynamic> _converteOrdemMap(Ordem order) => <String, dynamic>{
      'data': order.data,
      'data_atendimento': order.data_atendimento,
      'data_cancelamento': order.data_cancelamento,
      'data_final': order.data_final,
      'nome_cliente': order.cliente,
      'quantidade': order.quantidade,
      'produto': order.produto.reference,
      'valor': order.valor,
      'razao': order.razao,
      'estado': order.estado,
    };
