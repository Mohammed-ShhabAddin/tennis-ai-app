import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_weather_usecase.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeather getWeather;

  WeatherCubit(this.getWeather) : super(WeatherInitial());

  Future<void> fetchWeather(String city) async {
    try {
      emit(WeatherLoading());
      final weather = await getWeather.call(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Error: $e .'));
    }
  }
}
