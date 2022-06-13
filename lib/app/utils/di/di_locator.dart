import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:weather_app/app/data/repo/get_location.dart';
import 'package:weather_app/app/data/repo/weather_repo.dart';
import 'package:weather_app/app/data/services/geo_services.dart';
import 'package:weather_app/app/data/services/weather_services.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  _initRepositories();
  _initServices();
}

void _initRepositories() {
  getIt.registerSingleton<GetLocationRepo>(GetLocationRepo());
  getIt.registerSingleton<WeatherRepo>(WeatherRepo());
}

void _initServices() {
  getIt.registerSingleton<GeoServices>(GeoServices());
  getIt.registerSingleton<WeatherServices>(WeatherServices());
}
