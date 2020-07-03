import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Ordem.dart';
import '../Produto.dart';

class PedirProduto extends StatefulWidget {
  final Produto produto;

  PedirProduto({Key key, this.produto}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PedirProdutoState();
}

class _PedirProdutoState extends State<PedirProduto> {
  final _formKey = GlobalKey<FormState>();
  int _quantidade = 0;
  bool _mostraMensagem = false;
  String _mensagem = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Solicitar Produto')),
        body: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("Nome do Produto: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(widget.produto.nome,
                              style: TextStyle(fontSize: 18))
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text("Estoque: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(widget.produto.estoque.toString(),
                              style: TextStyle(fontSize: 18))
                        ],
                      )),
                  TextFormField(
                    onSaved: (valor) => setState(() {
                      _quantidade = int.parse(valor);
                    }),
                    decoration: const InputDecoration(
                        hintText: 'Insira a quantia desejada'),
                    validator: (valor) {
                      if (valor.isEmpty || valor == 0.toString())
                        return 'Porfavor insira uma quantia válida';

                      return null;
                    },
                  ),
                  mostrarMensagem(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final form = _formKey.currentState;
                          form.save();

                          if (_quantidade > widget.produto.estoque) {
                            setState(() {
                              _mensagem =
                                  "Não existe esse quantia de produtos no estoque";
                              _mostraMensagem = false;
                            });
                          }

                          widget.produto.reference.updateData(<String, dynamic>{
                            'estoque': widget.produto.estoque - _quantidade
                          });

                          var ordem = Ordem();
                          ordem.produto = widget.produto;
                          ordem.estado = 'Pendente';
                          ordem.data = DateTime.now();
                          ordem.cliente = 'Carlos';
                          ordem.valor = _quantidade * widget.produto.preco;

                          await Firestore.instance
                              .collection('ordem')
                              .add(ordem.toMap());

                          setState(() {
                            _mensagem = "Produto solicitado com sucesso";
                            _mostraMensagem = true;
                          });
                        }
                      },
                      child: Text('Pedir'),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget mostrarMensagem() {
    if (_mostraMensagem) return Text(_mensagem);

    return Container();
  }
}
