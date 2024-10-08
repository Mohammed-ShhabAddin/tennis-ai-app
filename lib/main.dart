import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tennis_ai_app/features/onboarding/onboarding_screen.dart';
import 'core/di/dependency_injection.dart';
import 'features/auth/data/repos/auth_repository.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/weather/domain/use_cases/get_weather_usecase.dart';
import 'features/weather/presentation/cubit/weather_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(GetIt.instance<AuthRepository>()),
        ),
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(GetIt.instance<GetWeather>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tennis Ai App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}
