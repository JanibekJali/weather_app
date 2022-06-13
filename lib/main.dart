import 'package:flutter/material.dart';
import 'package:weather_app/app/presentation/views/weather_view.dart';
import 'package:weather_app/app/utils/di/di_locator.dart';

void main() async {
  await initDI();
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
      home: WeatherView(),
    );
  }
}
