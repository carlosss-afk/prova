import 'package:aplicativonegociosprova/paginas/OrdemAberta.dart';
import 'package:aplicativonegociosprova/paginas/OrdemFechada.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Ordem.dart';

class OrdensAbertas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrdensAbertasState();
}

class _OrdensAbertasState extends State<OrdensAbertas> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('ordem').snapshots(),
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
    final data = Ordem.fromSnapshot(item);

    if (data.estado == "Atendido" || data.estado == "Cancelado")
      return Container();

    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrdemAberta(
                      ordem: data,
                    ))),
        child: Card(
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(data.data.day.toString() +
                        "/" +
                        data.data.month.toString() +
                        "/" +
                        data.data.year.toString()),
                    Text("R\$" + data.valor.toStringAsFixed(2)),
                    Text(data.estado)
                  ],
                ))));
  }
}
