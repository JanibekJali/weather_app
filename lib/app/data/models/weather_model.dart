import '../../utils/weather_util.dart';

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
    return WeatherModel(
        cityName: json['name'],
        celcius: WeatherUtil.kelvinToCelcius(
          json['main']['temp'] as num,
        ).toString(),
        icons: WeatherUtil.getWeatherIcon(json['main']['temp'] as num),
        description: WeatherUtil.getDescription(int.parse(
          WeatherUtil.kelvinToCelcius(json['main']['temp'] as num).toString(),
        )));
  }
}
