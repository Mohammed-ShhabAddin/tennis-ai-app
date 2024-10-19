import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/entities/weather_input_data.dart';
import '../../domain/use_cases/predict_usecase.dart';
import 'prediction_state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  final PredictUseCase predictUseCase;

  PredictionCubit(this.predictUseCase) : super(PredictionInitial());

  Future<void> makePrediction(WeatherEntity weather) async {
    emit(PredictionLoading());
    try {
      final inputData = WeatherInputData(
        outlookRainy:
            weather.conditionText.toLowerCase().contains('rain') ? 1 : 0,
        outlookSunny:
            weather.conditionText.toLowerCase().contains('sunny') ? 1 : 0,
        temperatureHot: weather.temperature > 25 ? 1 : 0,
        temperatureMild:
            (weather.temperature > 15 && weather.temperature <= 25) ? 1 : 0,
        humidityNormal: weather.humidity <= 70 ? 1 : 0,
      );

      final prediction = await predictUseCase.call(inputData);
      emit(PredictionLoaded(prediction));
    } catch (e) {
      emit(const PredictionError(' Failed to get prediction.'));
    }
  }
}
