import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/app/utils/constants/texts/app_texts.dart';
import 'package:weather_app/app/utils/http/http_util.dart';

import '../models/weather_model.dart';

class WeatherServices {
  static Future<Map<String, dynamic>> getWeatherByLocationService(
      {@required Position position}) async {
    final url =
        '${AppTexts.baseUrl}?lat=${position.latitude}&lon=${position.longitude}&appid=${AppTexts.openWeatherMapApiKey}';
    return await HttpUtil.get(url);
  }

  Future<Map<String, dynamic>> getWeatherByCityName(String typedCity) async {
    final url =
        '${AppTexts.baseUrl}?q=$typedCity&appid=${AppTexts.openWeatherMapApiKey}';
    return await HttpUtil.get(url);
  }

  Future<WeatherModel> getWeatherModelByLocation({Position position}) async {
    final _data = await getWeatherByLocationService(position: position);
    WeatherModel _weatherModel = WeatherModel.fromJson(_data);
    return _weatherModel;
  }

  Future<WeatherModel> getWeatherModelByCityName(
      {@required String cityName}) async {
    final _data = await getWeatherByCityName(cityName);
    WeatherModel _weatherModel = WeatherModel.fromJson(_data);
    return _weatherModel;
  }
}
