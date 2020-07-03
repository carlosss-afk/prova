import 'package:aplicativonegociosprova/paginas/OrdensFechadas.dart';
import 'package:aplicativonegociosprova/paginas/Produtos.dart';
import 'package:flutter/material.dart';

import 'OrdensAbertas.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pagina = 1;

  void _trocarPagina(pagina) {
    setState(() {
      _pagina = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          elevation: 1.5,
          child: ListView(
            children: <Widget>[
              DrawerHeader(child: Text('Menu')),
              InkWell(
                  onTap: () {
                    _trocarPagina(1);
                    Navigator.pop(context);
                  },
                  child: Card(child: ListTile(title: Text("Produtos")))),
              InkWell(
                  onTap: () {
                    _trocarPagina(2);
                    Navigator.pop(context);
                  },
                  child: Card(child: ListTile(title: Text("Ordens Fechadas")))),
              InkWell(
                  onTap: () {
                    _trocarPagina(3);
                    Navigator.pop(context);
                  },
                  child: Card(child: ListTile(title: Text("Ordens Abertas")))),
            ],
          )),
      body: Center(child: renderizarPagina(_pagina)),
    );
  }

  Widget renderizarPagina(int page) {
    switch (page) {
      case 1:
        return Container(child: Produtos());
        break;
      case 2:
        return Container(child: OrdensFechadas());
        break;
      case 3:
        return Container(child: OrdensAbertas());
        break;
      default:
        return Container(child: Text('Pagina não encontrada'));
    }
  }
}
