import 'package:aplicativonegociosprova/paginas/PedirProduto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Produto.dart';

class DetalhesProduto extends StatefulWidget {
  final Produto produto;

  DetalhesProduto({Key key, this.produto}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetalhesProdutoState();
}

class _DetalhesProdutoState extends State<DetalhesProduto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Detalhes do produto')),
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    informacaoProduto('Nome', widget.produto.nome),
                    informacaoProduto('Descrição', widget.produto.descricao),
                    informacaoProduto(
                        'Estoque', widget.produto.estoque.toString()),
                    informacaoProduto('Preço',
                        'R\$' + widget.produto.preco.toStringAsFixed(2)),
                    RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PedirProduto(
                                        produto: widget.produto,
                                      )));
                        },
                        color: Colors.blue,
                        child: Text(
                          'Pedir Produto',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ))));
  }

  Widget informacaoProduto(String label, String value) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Text(label + ': ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 18))
          ],
        ));
  }
}
