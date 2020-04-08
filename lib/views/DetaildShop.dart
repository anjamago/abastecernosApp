import 'package:flutter/material.dart';

class DetaildShop extends StatefulWidget {
  @override
  _DetaildShopState createState() => _DetaildShopState();
}

class _DetaildShopState extends State<DetaildShop> {
  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            Center(
              child: Padding(
                child: Text(
                  'Toma un foto del producto o factura que deseas reportar',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.all(20.0),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://s3.amazonaws.com/trazada-web/wp-content/uploads/2018/10/Google-Adwords-negocio-local.jpg'),
                  fit: BoxFit.cover,
                ),
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
