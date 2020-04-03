import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:abastecimiento/widgets/CalificarAbastecimiento.dart';

class Maps extends StatefulWidget {
  Maps({Key key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final map = new MapController();
  var currentLocation = LocationData;
  var location = new Location();

  Map<String, double> userLocation;
  String tipoMapa = 'streets';
  var centerLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF8B500),
        title: Text(
          'Mi direcion',
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.loop,
              color: Colors.white,
            ),
            onPressed: () {
              map.move(this.centerLocation, 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.repeat,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFFF8B500),
        onPressed: () {
          // streets, dark, light, outdoors, satellite
          if (tipoMapa == 'streets') {
            tipoMapa = 'dark';
          } else if (tipoMapa == 'dark') {
            tipoMapa = 'light';
          } else if (tipoMapa == 'light') {
            tipoMapa = 'outdoors';
          } else if (tipoMapa == 'outdoors') {
            tipoMapa = 'satellite';
          } else {
            tipoMapa = 'streets';
          }
        },
      ),
    );
  }

  void _showDialog() {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: new CalificarAbastecimiento(),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return simpleDialog;
          });
        });
  }

  Widget _crearFlutterMap() {
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
        this.centerLocation =
            LatLng(userLocation["latitude"], userLocation["longitude"]);
        map.move(this.centerLocation, 15);
      });
    });
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: this.centerLocation, zoom: 15),
      layers: [
        _crearMapa(),
        _crearMarcadores(),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
          'id': 'mapbox.$tipoMapa'
          // streets, dark, light, outdoors, satellite
        });
  }

  _crearMarcadores() {
    final maker = LatLng(4.7323, -74.086);
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
        width: 40.0,
        height: 40.0,
        point: this.centerLocation,
        builder: (context) => Container(
          child: FloatingActionButton(
            child: Icon(
              Icons.home,
              color: Colors.white,
            ),
            backgroundColor: Color(0xFFF8B500),
            onPressed: () {
              // streets, dark, light, outdoors, satellite
              print('mi home');
            },
          ),
        ),
      ),
      Marker(
        width: 40.0,
        height: 40.0,
        point: maker,
        builder: (context) => Container(
          child: FloatingActionButton(
            child: Icon(
              Icons.store,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            onPressed: () {
              _onButtonInfo(context);
            },
          ),
        ),
      )
    ]);
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    if (currentLocation != null) {
      Map<String, double> geoCord = {
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude
      };
      return geoCord;
    } else {
      return currentLocation;
    }
  }

  void _onButtonInfo(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              child: this._getModalList(context),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  _getModalList(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.store),
          title: Text('Mi tienda'),
          subtitle: Text(
            '300000',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Ver informacion completa del negocio'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('¿Que tan abastecido esta este negocio?'),
          onTap: _showDialog,
        ),
        ListTile(
          leading: Icon(Icons.trending_up),
          title: Text('Denunciar Alza De Precios'),
          onTap: () {},
        ),
      ],
    );
  }

/*   void showCustomDialog(BuildContext context) {
    print('modal');
    final _screen = MediaQuery.of(context).size;

    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: _screen.height * 0.6,
        width: _screen.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Califica el abastecimiento de esta tienda',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Nuestra calificación va del 1 al 5 likes, utiliza 5 para reportar que esta tienda esta muy bien abastecida y 1 para una tienda que esta muy poco abastecida',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _list,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Okay',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel!',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return simpleDialog;
          });
        });
  }
 */
}
