import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repos/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<FirebaseAuth>()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepository>()));
}
