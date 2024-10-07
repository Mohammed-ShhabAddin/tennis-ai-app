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
            child: IntrinsicHeight(
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
                            'الطقس في $city',
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
                      horizontal: screenWidth * 0.2,
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
                                    'جارٍ تحميل البيانات...',
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    state.weather.conditionIcon,
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.2,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                    'درجة الحرارة: ${state.weather.temperature} °C',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                    'سرعة الرياح: ${state.weather.windSpeed} كيلومتر/س',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                    'الرطوبة: ${state.weather.humidity}%',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                    'الرؤية: ${state.weather.visibility} كم',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                    'الحالة: ${state.weather.conditionText}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
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
                                'لا توجد بيانات',
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
      ),
    );
  }
}
