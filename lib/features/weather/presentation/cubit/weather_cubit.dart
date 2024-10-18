// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/entities/weather_input_data.dart';
// import '../../domain/use_cases/get_weather_usecase.dart';
// import '../../domain/use_cases/predict_usecase.dart';
// import 'weather_state.dart';

// class WeatherCubit extends Cubit<WeatherState> {
//   final GetWeather getWeather;
//   final PredictUseCase predictUseCase;

//   WeatherCubit(this.getWeather, this.predictUseCase) : super(WeatherInitial());

//   Future<void> fetchWeather(String city) async {
//     emit(WeatherLoading());
//     try {
//       final weather = await getWeather(city);

//       //  Predict the weather condition based on the input data
//       final inputData = WeatherInputData(
//         outlookRainy:
//             weather.conditionText.toLowerCase().contains('rain') ? 1 : 0,
//         outlookSunny:
//             weather.conditionText.toLowerCase().contains('sunny') ? 1 : 0,
//         temperatureHot: weather.temperature > 25 ? 1 : 0,
//         temperatureMild:
//             (weather.temperature > 15 && weather.temperature <= 25) ? 1 : 0,
//         humidityNormal: weather.humidity <= 70 ? 1 : 0,
//       );

//       final prediction = await predictUseCase(inputData);
//       emit(WeatherLoaded(weather, prediction));
//     } catch (e) {
//       emit(const WeatherError('Failed to fetch weather data.'));
//     }
//   }
// }

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
