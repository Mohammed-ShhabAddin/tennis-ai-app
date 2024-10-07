import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<String?> {
  LocationCubit() : super(null);

  void setLocation(String city) {
    emit(city);
  }
}
