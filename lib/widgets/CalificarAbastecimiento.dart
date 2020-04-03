import 'package:flutter/material.dart';

class CalificarAbastecimiento extends StatefulWidget {
  @override
  _CalificarAbastecimientoState createState() =>
      _CalificarAbastecimientoState();
}

class _CalificarAbastecimientoState extends State<CalificarAbastecimiento> {
  int _iconState = 0;
  List<Widget> _list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _list = [];
    print('carga');
    for (int i = 1; i <= 5; i++) {
      _list.add(
        IconButton(
          icon: Icon(
            Icons.thumb_up,
            size: 24,
            color: _iconState >= i ? Color(0xFFF8B500) : Colors.black,
          ),
          onPressed: () {
            print('cantidad $i');
            setState(() {
              _iconState = i;
            });
          },
        ),
      );
    }
    final _screen = MediaQuery.of(context).size;
    return Container(
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
            child: ButtonTheme(
              buttonColor: Color(0xFFF8B500),
              minWidth: MediaQuery.of(context).size.width * 0.8,
              height: 40.0,
              alignedDropdown: true,
              child: RaisedButton(
                color: Color(0xFFF8B500),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Confirmar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
