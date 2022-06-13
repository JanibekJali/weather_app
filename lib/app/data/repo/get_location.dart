import 'package:geolocator/geolocator.dart';
import 'package:weather_app/app/data/services/geo_services.dart';
import 'package:weather_app/app/utils/di/di_locator.dart';

class GetLocationRepo {
  Future<Position> getLocation() async {
    return await getIt<GeoServices>().getLocation();
  }
}
