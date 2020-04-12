import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:abastecimiento/providers/HttpBase.dart';
import 'dart:core';

class DetaildShop extends StatefulWidget {
  @override
  _DetaildShopState createState() => _DetaildShopState();
}

class _DetaildShopState extends State<DetaildShop> {
  HttpBase http = new HttpBase();
  Map<String, dynamic> listaReporte = {};
  List<Widget> listViews = [];
  String title = 'Nombre del local';
  String calificacion = '';

  loadService(dynamic id) {
    if (this.listaReporte.length == 0) {
      http.getApi('store/$id/').then((res) {
        Map<String, dynamic> body = json.decode(res.body);

        setState(() {
          title = body['name'];
          calificacion = body['raiting'];
          listaReporte = body; //as Map<String, dynamic>;
        });
         loadInfo();
        createList();
      }).catchError((error) => print(error.toString()));
    }
  }

  loadInfo() {
    this.listViews = [];
    this.listViews.add(Center(
          child: Padding(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(20.0),
          ),
        ));
    this.listViews.add(
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('public/ecommerceok.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
   

    loadService(data['id']);
    final _screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Información del Negocio'),
        backgroundColor: Color(0xFFF8B500),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: listViews,
        ),
      ),
    );
  }

  Widget createList() {
    final reports = this.listaReporte['reports'] as List;

    print('hola');
    for (var item in reports) {
      print(item);
      this.listViews.add(
            Row(
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 150.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://abastecernosapi.humc.co${item["photo"]}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Dia: ${item["created_on"]}',
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'hora',
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                )
              ],
            ),
          );
      this.listViews.add(Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  item['description'],
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ));
    }
  }
}
