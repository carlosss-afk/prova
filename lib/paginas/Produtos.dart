import 'package:aplicativonegociosprova/Produto.dart';
import 'package:aplicativonegociosprova/paginas/DetalhesProduto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Produtos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('produtos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          return constroiLista(context, snapshot.data.documents);
        },
      ),
    ));
  }

  Widget constroiLista(BuildContext context, dynamic snapshot) {
    return Column(
        children: snapshot
            .map<Widget>((item) => constroiItemLista(context, item))
            .toList());
  }

  Widget constroiItemLista(BuildContext context, DocumentSnapshot item) {
    final data = Produto.fromSnapshot(item);
    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetalhesProduto(
                      produto: data,
                    ))),
        child: Card(
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(data.nome),
                    Text("R\$" + data.preco.toStringAsFixed(2))
                  ],
                ))));
  }
}
