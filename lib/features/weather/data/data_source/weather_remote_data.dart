import 'package:dio/dio.dart';
import '../../../../core/utilies/strings.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<WeatherModel> getWeather(String city) async {
    final url =
        'https://api.weatherapi.com/v1/current.json?key=${AppStrings.apiKey}&q=$city';

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
