// lib/features/weather/presentation/ui/weather_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/curved_shape_widget.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';

class WeatherScreen extends StatelessWidget {
  final String city;

  const WeatherScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return BlocProvider(
        create: (_) => GetIt.instance<WeatherCubit>()..fetchWeather(city),
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
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
                              return Column(
                                children: [
                                  const CircularProgressIndicator(),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                    'Loading data...',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            } else if (state is WeatherLoaded) {
                              return Column(
                                children: [
                                  Image.network(
                                    state.weather.conditionIcon,
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.2,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),

                                  SizedBox(height: screenHeight * 0.04),
                                  // Grid of weather details
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    children: [
                                      WeatherDetailItem(
                                        icon: Icons.thermostat_outlined,
                                        label: 'Temp',
                                        value:
                                            '${state.weather.temperature} °C',
                                      ),
                                      WeatherDetailItem(
                                        icon: Icons.air,
                                        label: 'Wind',
                                        value:
                                            '${state.weather.windSpeed} km/h',
                                      ),
                                      WeatherDetailItem(
                                        icon: Icons.opacity,
                                        label: 'Humidity',
                                        value: '${state.weather.humidity}%',
                                      ),
                                      WeatherDetailItem(
                                        icon: Icons.visibility,
                                        label: 'Visibility',
                                        value: '${state.weather.visibility} km',
                                      ),
                                      WeatherDetailItem(
                                        icon: Icons.cloud,
                                        label: 'Condition',
                                        value: state.weather.conditionText,
                                      ),
                                      const WeatherDetailItem(
                                        icon: Icons.sports_tennis_rounded,
                                        label: '....',
                                        value: '...',
                                      ),
                                    ],
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
        ));
  }
}

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetailItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
