import 'package:geolocator/geolocator.dart';
import 'package:weather_app/app/data/services/weather_services.dart';
import 'package:weather_app/app/utils/di/di_locator.dart';

import '../models/weather_model.dart';

class WeatherRepo {
  Future<WeatherModel> getWeatherModelByLocation({Position position}) async {
    return await getIt<WeatherServices>()
        .getWeatherModelByLocation(position: position);
  }

  Future<WeatherModel> getWeatherModelByCityName({String city}) async {
    return await getIt<WeatherServices>()
        .getWeatherModelByCityName(cityName: city);
  }
}
