import '../entities/weather_entity.dart';
import '../reopsitories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<WeatherEntity> call(String city) {
    return repository.getWeather(city);
  }
}
