import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
//import 'package:abastecimiento/widgets/CalificarAbastecimiento.dart';
import 'package:abastecimiento/widgets/CalficacionStart.dart';
import 'package:abastecimiento/providers/HttpBase.dart';

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
  HttpBase http = new HttpBase();
  List<Marker> _marker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaderService();
    new Timer(
      new Duration(seconds: 2),
      () {
        loaderService();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //loaderService();
    return Scaffold(
      body: _crearFlutterMap(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFFF8B500),
        onPressed: () {
          // streets, dark, light, outdoors, satellite
          print(this.centerLocation);
          map.move(this.centerLocation, 15);
          loaderService();
        },
      ),
    );
  }

  void _showDialog(dynamic data) {
    int _id = data['id'];
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: CalficacionStart(id: _id),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return simpleDialog;
          });
        });
  }

  loaderService() {
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
        this.centerLocation =
            LatLng(userLocation["latitude"], userLocation["longitude"]);
        map.move(this.centerLocation, 15);
      });
    });
    _crearMarcadores(userLocation);
  }

  Widget _crearFlutterMap() {
    //var widgetElement = _crearMarcadores(userLocation);
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: this.centerLocation, zoom: 15),
      layers: [_crearMapa(), MarkerLayerOptions(markers: _marker)],
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

  Future _crearMarcadores(Map<String, double> _location) async {
    _marker = [
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
            onPressed: () {},
          ),
        ),
      ),
    ];

    if (_location != null) {
      dynamic response = await http.getApi(
          'store/${_location["latitude"]}/${_location["longitude"]}/5/');
      var data = json.decode(response.body);
      print(data[0]);
      for (var x in data) {
        final maker = LatLng(x['latitude'], x['longitude']);
        final _mk = Marker(
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
                print(x);
                _onButtonInfo(context, x);
              },
            ),
          ),
        );

        setState(() {
          _marker.add(_mk);
        });
      }
    }

    //return MarkerLayerOptions(markers: _marker);
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

  void _onButtonInfo(BuildContext context, dynamic data) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              child: this._getModalList(context, data),
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

  _getModalList(BuildContext context, dynamic data) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.store),
          title: Text(data['name']),
          /* subtitle: Text(
            '300000',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ), */
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Ver informacion completa del negocio'),
          onTap: () => Navigator.pushNamed(context, '/detail',
              arguments: {"id": data['id']}),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('¿Que tan abastecido esta este negocio?'),
          onTap: () => _showDialog(data),
        ),
        ListTile(
          leading: Icon(Icons.trending_up),
          title: Text('Denunciar Alza De Precios'),
          onTap: () {
            Navigator.pushNamed(context, '/price',
                arguments: {"id": data['id']});
          },
        ),
      ],
    );
  }
}
