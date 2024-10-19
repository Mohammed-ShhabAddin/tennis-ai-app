import '../entities/weather_entity.dart';
import '../entities/weather_input_data.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather(String city);

  Future<int> predictWeatherCondition(WeatherInputData inputData);
}
