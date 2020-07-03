import 'package:aplicativonegociosprova/Ordem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdemAberta extends StatefulWidget {
  final Ordem ordem;

  OrdemAberta({Key key, this.ordem}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _OrdemAbertaState();
}

class _OrdemAbertaState extends State<OrdemAberta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedidos Abertos')),
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
    col.children
        .add(criaItemLista('Nome do Produto', widget.ordem.produto.nome));
    col.children.add(criaItemLista('Nome do Cliente', widget.ordem.cliente));
    col.children
        .add(criaItemLista('Quantidade', widget.ordem.quantidade.toString()));

    if (widget.ordem.estado == "Atendimento") {
      col.children.add(criaItemLista(
          'Data de Finalização',
          widget.ordem.data_final.day.toString() +
              "/" +
              widget.ordem.data_final.month.toString() +
              "/" +
              widget.ordem.data_final.year.toString()));
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
