import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String nome;
  String descricao;
  int estoque;
  double preco;

  DocumentReference reference;

  Produto({this.nome, this.descricao, this.estoque, this.preco});

  factory Produto.fromMap(Map<String, dynamic> map) {
    Produto produto = Produto();
    if (map['nome'] != null)
      produto.nome = map['nome'];
    else
      produto.nome = '';

    if (map['descricao'] != null)
      produto.descricao = map['descricao'];
    else
      produto.descricao = '';

    if (map['estoque'] != null)
      produto.estoque = map['estoque'];
    else
      produto.estoque = 0;

    if (map['preco'] != null)
      produto.preco = map['preco'].toDouble();
    else
      produto.preco = 0.00;

    return produto;
  }

  factory Produto.fromSnapshot(DocumentSnapshot snapshot) {
    Produto produto = Produto.fromMap(snapshot.data);
    produto.reference = snapshot.reference;
    return produto;
  }
}
