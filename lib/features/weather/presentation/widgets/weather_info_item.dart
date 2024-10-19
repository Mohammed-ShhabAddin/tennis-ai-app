import 'package:flutter/material.dart';

class WeatherInfoItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;
  final String? iconUrl;

  const WeatherInfoItem({
    super.key,
    this.icon,
    required this.label,
    required this.value,
    this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          iconUrl != null && iconUrl!.isNotEmpty
              ? Image.network(
                  iconUrl!,
                  height: 40,
                  width: 40,
                )
              : Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
