import 'dart:convert' as convert;
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/pages/city_page.dart';
import 'package:weather_app/utils/weather_util.dart';

import '../constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _celcius = '';
  String _cityName = '';
  String _description = '';
  String _icons;
  bool _isLoading = false;
  @override
  void initState() {
    _showWeatherByLocation();
    super.initState();
  }

  Future<void> _showWeatherByLocation() async {
    final position = await _determinePosition();
    await getWeatherByLocation(position: position);

    // log('position latitude  ===>> ${position.latitude}');
    // log('position longitude ===>> ${position.longitude}');
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherByLocation({@required Position position}) async {
    setState(() {
      _isLoading = true;
    });
    final client = http.Client();
    try {
      Uri _uri = Uri.parse(
        '$baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$openWeatherMapApiKey$kelvin',
      );
      final response = await client.get(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        // log('body ===>>> $body');
        final _data = convert.jsonDecode(body) as Map<String, dynamic>;
        // log('_data ====>>> $_data');

        final cityName = _data['name'];
        _cityName = cityName;
        // log('Shardyn aty ===> $cityName');
        final temp = _data['main']['temp'] as num;
        final id = _data['weather'][0]['id'];

        // log('TEMP ===>> $temp');
        _icons = WeatherUtil.getWeatherIcon(id.toInt());
        // _celcius = temp.toStringAsFixed(0);
        _celcius = temp.round().toString();
        _description = WeatherUtil.getDescription(int.parse(_celcius));
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception(e);
    }
  }

  // typedCity = Jazylgan shaar
  Future<void> getWeatherByCityName(String typedCity) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final client = http.Client();
      final url = '$baseUrl?q=$typedCity&appid=$openWeatherMapApiKey$kelvin';
      Uri _uri = Uri.parse(url);
      final response = await client.get(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        final _data = convert.jsonDecode(body) as Map<String, dynamic>;

        // int
        // double
        // num
        final temp = _data['main']['temp'] as num;
        final id = _data['weather'][0]['id'];
        _celcius = temp.round().toString();
        _icons = WeatherUtil.getWeatherIcon(id.toInt());
        _cityName = _data['name'];
        _description = WeatherUtil.getDescription(int.parse(_celcius));
        setState(() {
          _isLoading = false;
        });
      }
    } catch (kata) {
      setState(() {
        _isLoading = false;
      });
      throw Exception(kata);
    }
  }

// 5 = 6 = 6
//  5 = 4 = 4;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
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
                log('_typedCity====>>> $_typedCity');
                await getWeatherByCityName(_typedCity.toString());
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        _celcius.isEmpty
                            ? '$_celcius \u00B0🌞 '
                            : ' $_celcius \u00B0 $_icons ',
                        style: const TextStyle(
                            fontSize: 100.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 35.0),
                      child: Text(
                        _cityName,
                        style: const TextStyle(
                            fontSize: 100.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: _size * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _description,
                        style: const TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
