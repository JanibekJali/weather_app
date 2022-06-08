import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/weather_model.dart';

import '../../constants.dart';

class WeatherServices {
  static Future<Map<String, dynamic>> getWeatherByLocationService(
      {@required Position position}) async {
    final client = http.Client();
    try {
      Uri _uri = Uri.parse(
        '$baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$openWeatherMapApiKey',
      );
      final response = await client.get(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        final _data = jsonDecode(body) as Map<String, dynamic>;
        return _data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Map<String, dynamic>> getWeatherByCityName(
      String typedCity) async {
    try {
      final client = http.Client();
      final url = '$baseUrl?q=$typedCity&appid=$openWeatherMapApiKey$kelvin';
      Uri _uri = Uri.parse(url);
      final response = await client.get(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        final _data = jsonDecode(body) as Map<String, dynamic>;
        return _data;

        // final temp = _data['main']['temp'] as num;
        // final id = _data['weather'][0]['id'];
        // _celcius = temp.round().toString();
        // _icons = WeatherUtil.getWeatherIcon(id.toInt());
        // _cityName = _data['name'];
        // _description = WeatherUtil.getDescription(int.parse(_celcius));

      } else {
        return null;
      }
    } catch (kata) {
      throw Exception(kata);
    }
  }

  static Future<WeatherModel> getWeatherModelByLocation(
      {@required Position position}) async {
    final _data = await getWeatherByLocationService(position: position);
    WeatherModel _weatherModel = WeatherModel.fromJson(_data);
    return _weatherModel;
  }

  static Future<WeatherModel> getWeatherModelByCityName(
      {@required String cityName}) async {
    final _data = await getWeatherByCityName(cityName);
    WeatherModel _weatherModel = WeatherModel.fromJson(_data);
    return _weatherModel;
  }
}
