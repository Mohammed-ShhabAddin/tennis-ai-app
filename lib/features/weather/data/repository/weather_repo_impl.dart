import 'package:tennis_ai_app/features/weather/data/data_source/weather_remote_data.dart';
import 'package:tennis_ai_app/features/weather/domain/reopsitories/weather_repository.dart';

import '../../domain/entities/weather_entity.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<WeatherEntity> getWeather(String city) async {
    return await remoteDataSource.getWeather(city);
  }
}
