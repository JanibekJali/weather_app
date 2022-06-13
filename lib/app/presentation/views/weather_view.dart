import 'package:flutter/material.dart';
import 'package:weather_app/app/data/repo/weather_repo.dart';
import 'package:weather_app/app/presentation/widgets/weather_view_content.dart';
import 'package:weather_app/app/utils/di/di_locator.dart';

import '../../data/models/weather_model.dart';
import '../../data/repo/get_location.dart';

import 'city_page.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({Key key}) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  bool _isLoading = false;
  WeatherModel _weatherModel;
  @override
  void initState() {
    _showWeatherByLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => CityView(),
                  ),
                );
                await getWeatherByCityName(typedCity: _typedCity);
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
                child: WeatherViewContent(
                  celcius: _weatherModel.celcius,
                  icons: _weatherModel.icons,
                  cityName: _weatherModel.cityName,
                  description: _weatherModel.description,
                ),
              ),
      ),
    );
  }

  Future<void> _showWeatherByLocation() async {
    setState(() {
      _isLoading = true;
    });
    final _position = await getIt<GetLocationRepo>().getLocation();
    _weatherModel = await getIt<WeatherRepo>()
        .getWeatherModelByLocation(position: _position);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getWeatherByCityName({String typedCity}) async {
    setState(() {
      _isLoading = true;
    });
    _weatherModel =
        await getIt<WeatherRepo>().getWeatherModelByCityName(city: typedCity);
    setState(() {
      _isLoading = false;
    });
  }
}
