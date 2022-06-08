import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/services/weather_services.dart';

import '../data/services/geo_services.dart';
import 'city_page.dart';

class WeatherModelPage extends StatefulWidget {
  const WeatherModelPage({Key key}) : super(key: key);

  @override
  _WeatherModelPageState createState() => _WeatherModelPageState();
}

class _WeatherModelPageState extends State<WeatherModelPage> {
  bool _isLoading = false;
  WeatherModel _weatherModel;
  @override
  void initState() {
    _showWeatherByLocation();
    super.initState();
  }

  Future<void> _showWeatherByLocation() async {
    setState(() {
      _isLoading = true;
    });
    final _position = await GeoServices.getLocation();
    _weatherModel =
        await WeatherServices.getWeatherModelByLocation(position: _position);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () async {
            await _showWeatherByLocation();
          },
          icon: const Icon(
            Icons.navigation,
            size: 60.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: IconButton(
              onPressed: (() async {
                final _typedCity = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CityPage(),
                  ),
                );
                // await getWeatherByCityName(_typedCity);
              }),
              icon: const Icon(
                Icons.location_city,
                size: 60.0,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.cyanAccent,
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/back_photo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: WeatherPageContent(),
              ),
      ),
    );
  }
}

class WeatherPageContent extends StatelessWidget {
  WeatherPageContent({this.celcius, this.icons});
  final String celcius;
  final String icons;
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
            '_cityName',
            style: const TextStyle(
                fontSize: 100.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
            // height: _size * 0.1,
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '_description',
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
