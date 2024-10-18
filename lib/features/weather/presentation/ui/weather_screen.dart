import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/curved_shape_widget.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../domain/entities/weather_entity.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../cubit/prediction_cubit.dart';
import '../widgets/prediction_dialog.dart';
import '../widgets/weather_info_item.dart';

class WeatherScreen extends StatelessWidget {
  final String city;

  const WeatherScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return BlocProvider(
      create: (_) => getIt<WeatherCubit>()..fetchWeather(city),
      child: Scaffold(
        backgroundColor: AppColors.blueColor.withOpacity(0.75),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight -
                  mediaQuery.padding.top -
                  mediaQuery.padding.bottom,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CurvedShapeWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.1),
                        Image.asset(
                          'assets/images/tennis-ball.png',
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.2,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Weather in $city',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: mediaQuery.padding.top + 20,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.blueColor.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.3),
                      BlocBuilder<WeatherCubit, WeatherState>(
                        builder: (context, state) {
                          if (state is WeatherLoading) {
                            return SizedBox(
                              width: screenWidth,
                              child: Column(
                                children: [
                                  const CircularProgressIndicator(),
                                  SizedBox(
                                    height: screenHeight * 0.2,
                                    width: screenWidth * 0.2,
                                  ),
                                  Text(
                                    'Loading data...',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          } else if (state is WeatherLoaded) {
                            return Column(
                              children: [
                                GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.5,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    WeatherInfoItem(
                                      icon: Icons.thermostat_outlined,
                                      label: 'Temperature',
                                      value: '${state.weather.temperature} °C',
                                    ),
                                    WeatherInfoItem(
                                      icon: Icons.air,
                                      label: 'Wind Speed',
                                      value: '${state.weather.windSpeed} km/h',
                                    ),
                                    WeatherInfoItem(
                                      icon: Icons.opacity,
                                      label: 'Humidity',
                                      value: '${state.weather.humidity}%',
                                    ),
                                    WeatherInfoItem(
                                      icon: Icons.visibility,
                                      label: 'Visibility',
                                      value: '${state.weather.visibility} km',
                                    ),
                                    WeatherInfoItem(
                                      icon: Icons.cloud,
                                      label: 'Condition',
                                      value: state.weather.conditionText,
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                GradientButton(
                                  text: 'Get prediction',
                                  onPressed: () {
                                    _showPredictionDialog(
                                        context, state.weather);
                                  },
                                ),
                              ],
                            );
                          } else if (state is WeatherError) {
                            return Text(
                              state.message,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Text(
                              'No data available',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPredictionDialog(BuildContext context, WeatherEntity weather) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (_) => getIt<PredictionCubit>(),
          child: PredictionDialog(weather: weather),
        );
      },
    );
  }
}
