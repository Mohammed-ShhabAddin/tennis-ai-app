class WeatherEntity {
  final double temperature;
  final double windSpeed;
  final int humidity;
  final double visibility;
  final String conditionText;
  final String conditionIcon;

  WeatherEntity({
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.visibility,
    required this.conditionText,
    required this.conditionIcon,
  });
}
