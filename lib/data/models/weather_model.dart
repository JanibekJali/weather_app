import 'package:weather_app/data/services/weather_services.dart';
import 'package:weather_app/utils/weather_util.dart';

class WeatherModel {
  final String celcius;
  final String cityName;
  final String description;
  final String icons;

  WeatherModel({
    this.celcius,
    this.cityName,
    this.description,
    this.icons,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final kelvin = json['name']['temp'] as num;
    return WeatherModel(
        cityName: json['name'],
        celcius: WeatherUtil.kelvinToCelcius(
          kelvin,
        ),
        icons: WeatherUtil.getWeatherIcon(kelvin),
        description: WeatherUtil.getDescription(int.parse(
          WeatherUtil.kelvinToCelcius(kelvin),
        )));
  }
}
