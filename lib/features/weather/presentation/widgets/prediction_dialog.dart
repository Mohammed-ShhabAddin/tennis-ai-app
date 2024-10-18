import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_ai_app/core/theme/colors.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../domain/entities/weather_entity.dart';
import '../cubit/prediction_cubit.dart';
import '../cubit/prediction_state.dart';

class PredictionDialog extends StatelessWidget {
  final WeatherEntity weather;

  const PredictionDialog({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final predictionCubit = context.read<PredictionCubit>();

    return AlertDialog(
      title: const Text(
        'AI Prediction',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.xBlueColor.withOpacity(0.95),
      content: BlocBuilder<PredictionCubit, PredictionState>(
        builder: (context, state) {
          if (state is PredictionInitial) {
            predictionCubit.makePrediction(weather);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PredictionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PredictionLoaded) {
            return Text(
              state.prediction == 1
                  ? 'The weather is great! You can train for tennis today.'
                  : 'Sorry, the weather isn’t suitable for tennis today.',
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            );
          } else if (state is PredictionError) {
            return Text(
              state.message,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            );
          } else {
            return const Text('No prediction made yet.');
          }
        },
      ),
      actions: [
        GradientButton(
          text: 'Go Back',
          onPressed: () {
            Navigator.of(context).pop();
          },
          height: 40,
        ),
      ],
    );
  }
}
