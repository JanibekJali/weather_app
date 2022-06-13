import 'package:flutter/material.dart';

class WeatherViewContent extends StatelessWidget {
  const WeatherViewContent({
    Key key,
    @required this.celcius,
    @required this.icons,
    @required this.cityName,
    @required this.description,
  }) : super(key: key);

  final String celcius;
  final String icons;
  final String cityName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            celcius.isEmpty ? '$celcius \u00B0🌞 ' : ' $celcius \u00B0 $icons ',
            style: const TextStyle(
                fontSize: 100.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 35.0),
          child: Text(
            cityName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 80.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 40.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
