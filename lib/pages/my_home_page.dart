import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/services/geo_services.dart';
import 'package:weather_app/data/services/weather_services.dart';
import 'package:weather_app/pages/city_page.dart';
import 'package:weather_app/utils/weather_util.dart';

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
    setState(() {
      _isLoading = true;
    });
    final _position = await GeoServices.getLocation();
    await getWeatherByLocation(position: _position);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                await getWeatherByCityName(_typedCity);
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

  Future<void> getWeatherByLocation({Position position}) async {
    final _data =
        await WeatherServices.getWeatherByLocationService(position: position);

    final kelvin = _data['main']['temp'] as num;
    _cityName = _data['name'];

    _icons = WeatherUtil.getWeatherIcon(kelvin);
    _celcius = WeatherUtil.kelvinToCelcius(kelvin);
    _description = WeatherUtil.getDescription(int.parse(_celcius));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getWeatherByCityName(String typedCity) async {
    setState(() {
      _isLoading = true;
    });
    final _data = await WeatherServices.getWeatherByCityName(typedCity);

    final kelvin = _data['main']['temp'] as num;
    _celcius = kelvin.round().toString();
    _icons = WeatherUtil.getWeatherIcon(kelvin);
    _cityName = _data['name'];
    _description = WeatherUtil.getDescription(int.parse(_celcius));

    setState(() {
      _isLoading = false;
    });
  }
}
