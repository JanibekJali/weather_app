import 'package:flutter/material.dart';
import 'package:weather_app/misaldar/misal_page.dart';
import 'package:weather_app/misaldar/test_page.dart';
import 'package:weather_app/pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      // home: TestPage(),
      // home: MisalPage(baa: 2, name: 'Janibek'),
    );
  }
}
