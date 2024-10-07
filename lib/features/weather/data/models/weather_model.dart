import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.temperature,
    required super.windSpeed,
    required super.humidity,
    required super.visibility,
    required super.conditionText,
    required super.conditionIcon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['current']['temp_c'] as num).toDouble(),
      windSpeed: (json['current']['wind_kph'] as num).toDouble(),
      humidity: json['current']['humidity'] as int,
      visibility: (json['current']['vis_km'] as num).toDouble(),
      conditionText: json['current']['condition']['text'] as String,
      conditionIcon: 'https:${json['current']['condition']['icon']}', //
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'visibility': visibility,
      'conditionText': conditionText,
      'conditionIcon': conditionIcon,
    };
  }
}
