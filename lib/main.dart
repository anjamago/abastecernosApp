import 'package:flutter/material.dart';
import 'package:abastecimiento/widgets/Onboarding.dart';
import 'package:abastecimiento/views/Maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:  {
        '/': (context) => Onboarding(),
        '/maps': (context) => Maps(),
      },
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
    );
  }
}
