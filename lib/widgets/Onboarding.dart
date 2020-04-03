import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final int _numPage = 3;
  final PageController _pageController = new PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> _list = [];
    for (int i = 0; i < _numPage; i++) {
      _list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return _list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFFF8B500),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('skip'),
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 0.0,
                          bottom: 20.0,
                          left: 40.0,
                          right: 40.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: SvgPicture.asset(
                                'public/Group1225.svg',
                                height: 250.0,
                                width: 200.0,
                              ),
                            ),
                            Text(
                              'Encuentra Tiendas Cercanas',
                              style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Echa un vistazo a las tiendas que tienes cerca y revisar el nivel de abastecimiento de estas.',
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 0.0,
                          bottom: 20.0,
                          left: 40.0,
                          right: 40.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: SvgPicture.asset(
                                'public/Group1226.svg',
                                height: 250.0,
                                width: 200.0,
                              ),
                            ),
                            Text(
                              'Denuncia alza de Precios en los Productos',
                              style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Cuando sepas de algún producto que este siendo cobrado con un precio mayor, Reportalo!',
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 0.0,
                          bottom: 20.0,
                          left: 40.0,
                          right: 40.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: SvgPicture.asset(
                                'public/Group1227.svg',
                                height: 250.0,
                                width: 200.0,
                              ),
                            ),
                            Text(
                              'Gracias por hacer parte de abastecernos.co',
                              style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Ahora si tienes algún conocido o familiar que le pueda servir esta aplicación, por favor compártela para que seamos muchos más y nos ayudemos entre todos!',
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPage - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Siguiente',
                                  style: TextStyle(
                                      color: Color(0xFFF8B500), fontSize: 22.0),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFFF8B500),
                                  size: 30.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPage - 1
          ? Container(
              height: 50.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => {},
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: ButtonTheme(
                      buttonColor: Color(0xFFF8B500),
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      height: 60.0,
                      alignedDropdown: true,
                      child: RaisedButton(
                        color: Color(0xFFF8B500),
                        onPressed: () => Navigator.pushNamed(context, '/maps'),
                        child: Text(
                          'Ir al Inicio',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
