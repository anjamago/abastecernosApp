import 'dart:io';

import 'package:abastecimiento/providers/HttpBase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrinceRise extends StatefulWidget {
  @override
  _PrinceRiseState createState() => _PrinceRiseState();
}

class _PrinceRiseState extends State<PrinceRise> {
  HttpBase http = new HttpBase();
  File _image;
  final contentControl = TextEditingController();
  

  Future capturaImg() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this._image = image;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this._image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    print(data);
    final _screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Denunciar Alza de Precios'),
        backgroundColor: Color(0xFFF8B500),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
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
              height: _screen.height * 0.5,
              color: Colors.black12,
              child: _buttonsImage(context),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 10.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Text(
                'Descríbenos tu denuncia para que otras personas puedan conocer más',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: contentControl,
                  minLines: 5,
                  maxLines: 12,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Deja aqui tu descripción',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: ButtonTheme(
                  buttonColor: Color(0xFFF8B500),
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  height: 50.0,
                  alignedDropdown: true,
                  child: RaisedButton(
                    color: Color(0xFFF8B500),
                    onPressed: (){
                      final json = {
                          "store_id": data['id'],
                          "description": contentControl.value,
                          "photo":_image
                        };
                      http.postApi('/report/store/', data).then((res)=>res.body).whenComplete((){
                         Navigator.pop(context);
                      });
                    },
                    child: Text(
                      'Enviar Reporte',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buttonsImage(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    if (this._image == null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            child: FloatingActionButton(
              heroTag: 'btn2',
              child: Icon(
                Icons.folder,
                color: Colors.white,
              ),
              onPressed: getImage,
              tooltip: 'Cargar archivo',
              backgroundColor: Color(0xFFF8B500),
            ),
            padding: EdgeInsets.all(10.0),
          ),
          Padding(
            child: FloatingActionButton(
              heroTag: 'btn3',
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onPressed: capturaImg,
              tooltip: 'Tomar foto',
              backgroundColor: Color(0xFFF8B500),
            ),
            padding: EdgeInsets.all(10.0),
          )
        ],
      );
    }
    if (_image != null) {
      return Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Image.file(
                    _image,
                    fit: BoxFit.cover,
                    width: _screen.width,
                    height: _screen.height * 0.48,
                  ),
                ),
                onDoubleTap: () {
                  setState(() {
                    _image = null;
                  });
                },
              ),
            ],
          ),
        ],
      );
    }
  }
}
