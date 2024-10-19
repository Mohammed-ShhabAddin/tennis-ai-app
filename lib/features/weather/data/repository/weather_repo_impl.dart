import 'package:dio/dio.dart';
import 'package:tennis_ai_app/features/weather/data/data_source/weather_remote_data.dart';
import 'package:tennis_ai_app/features/weather/domain/reopsitories/weather_repository.dart';

import '../../domain/entities/weather_entity.dart';
import '../../domain/entities/weather_input_data.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final Dio dio;

  WeatherRepositoryImpl(this.remoteDataSource, this.dio);

  @override
  Future<WeatherEntity> getWeather(String city) async {
    return await remoteDataSource.getWeather(city);
  }

  @override
  Future<int> predictWeatherCondition(WeatherInputData inputData) async {
    final response = await dio.post(
      // 'http://10.0.2.2:5001/predict',
      'http://192.168.1.71:5001/predict',
      data: inputData.toJson(),
    );

    if (response.statusCode == 200) {
      return response.data['prediction'][0] as int;
    } else {
      throw Exception('Failed to get prediction');
    }
  }
}
