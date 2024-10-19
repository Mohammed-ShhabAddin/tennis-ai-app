class WeatherInputData {
  final int outlookRainy;
  final int outlookSunny;
  final int temperatureHot;
  final int temperatureMild;
  final int humidityNormal;

  WeatherInputData({
    required this.outlookRainy,
    required this.outlookSunny,
    required this.temperatureHot,
    required this.temperatureMild,
    required this.humidityNormal,
  });

  Map<String, dynamic> toJson() {
    return {
      'features': [
        outlookRainy,
        outlookSunny,
        temperatureHot,
        temperatureMild,
        humidityNormal,
      ],
    };
  }
}
