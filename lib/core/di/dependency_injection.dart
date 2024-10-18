import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repos/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/weather/data/data_source/weather_remote_data.dart';
import '../../features/weather/data/repository/weather_repo_impl.dart';
import '../../features/weather/domain/reopsitories/weather_repository.dart';
import '../../features/weather/domain/use_cases/get_weather_usecase.dart';
import '../../features/weather/domain/use_cases/predict_usecase.dart';
import '../../features/weather/presentation/cubit/prediction_cubit.dart';
import '../../features/weather/presentation/cubit/weather_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  //Auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<FirebaseAuth>()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepository>()));

  //Weather
  //Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  //WeatherRemoteDataSource
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(getIt<Dio>()),
  );

  // WeatherRepository
  getIt.registerLazySingleton<WeatherRepositoryImpl>(
    () => WeatherRepositoryImpl(getIt<WeatherRemoteDataSource>(), getIt<Dio>()),
  );
  // Register Repositories
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(getIt<WeatherRemoteDataSource>(), getIt<Dio>()),
  );
  // Register GetWeather UseCase
  getIt.registerLazySingleton<GetWeather>(
    () => GetWeather(getIt<WeatherRepositoryImpl>()),
  );
  // Register Predict UseCase
  getIt.registerLazySingleton<PredictUseCase>(
    () => PredictUseCase(getIt<WeatherRepository>()),
  );

  // Register WeatherCubit
  getIt.registerFactory<WeatherCubit>(
    () => WeatherCubit(
      getIt<GetWeather>(),
    ),
  );

  getIt.registerFactory<PredictionCubit>(
    () => PredictionCubit(getIt<PredictUseCase>()),
  );
}
