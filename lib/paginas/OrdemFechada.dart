import 'package:aplicativonegociosprova/Ordem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdemFechada extends StatefulWidget {
  final Ordem ordem;

  OrdemFechada({Key key, this.ordem}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _OrdemFechadaState();
}

class _OrdemFechadaState extends State<OrdemFechada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedidos Fechados')),
      body: Container(padding: const EdgeInsets.all(10), child: criaLista()),
    );
  }

  Widget criaLista() {
    var col = Column(
      children: <Widget>[],
    );

    col.children.add(criaItemLista(
        'Data do Pedido',
        widget.ordem.data.day.toString() +
            "/" +
            widget.ordem.data.month.toString() +
            "/" +
            widget.ordem.data.year.toString()));
    col.children.add(criaItemLista('Valor', widget.ordem.valor.toString()));
    col.children.add(criaItemLista('Estado', widget.ordem.estado));

    if (widget.ordem.estado == "Atendido") {
      col.children.add(criaItemLista(
          'Data de Atendimento',
          widget.ordem.data_atendimento.day.toString() +
              "/" +
              widget.ordem.data_atendimento.month.toString() +
              "/" +
              widget.ordem.data_atendimento.year.toString()));
      col.children
          .add(criaItemLista('Nome do Produto', widget.ordem.produto.nome));
      col.children
          .add(criaItemLista('Quantidade', widget.ordem.quantidade.toString()));
    } else {
      col.children.add(criaItemLista(
          'Data de Cancelamento',
          widget.ordem.data_cancelamento.day.toString() +
              "/" +
              widget.ordem.data_cancelamento.month.toString() +
              "/" +
              widget.ordem.data_cancelamento.year.toString()));
      col.children.add(criaItemLista('Motivo', widget.ordem.razao));
    }

    return col;
  }

  Widget criaItemLista(String label, String valor) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Text(label + ": ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(valor, style: TextStyle(fontSize: 18))
          ],
        ));
  }
}
