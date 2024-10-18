import '../entities/weather_input_data.dart';
import '../reopsitories/weather_repository.dart';

class PredictUseCase {
  final WeatherRepository repository;

  PredictUseCase(this.repository);

  Future<int> call(WeatherInputData inputData) {
    return repository.predictWeatherCondition(inputData);
  }
}
