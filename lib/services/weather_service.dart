import 'package:flutter/material.dart';

class WeatherData {
  final double temperature;
  final String condition;
  final IconData icon;

  WeatherData({
    required this.temperature,
    required this.condition,
    required this.icon,
  });
}

class AlertData {
  final String day;
  final String alert;
  final String type; // Good, Warning, Caution

  AlertData({
    required this.day,
    required this.alert,
    required this.type,
  });
}

class WeatherService {
  static WeatherData getCurrentWeather(String location) {
    final int hash = location.toLowerCase().hashCode;
    
    // Deterministic mock data based on location hash
    final double temp = 22 + (hash % 12); // Range 22-34
    
    final List<String> conditions = ['Sunny', 'Mostly Sunny', 'Cloudy', 'Partly Cloudy', 'Light Rain'];
    final condition = conditions[hash % conditions.length];
    
    IconData icon;
    if (condition.contains('Rain')) {
      icon = Icons.umbrella;
    } else if (condition.contains('Cloudy')) {
      icon = Icons.wb_cloudy_outlined;
    } else {
      icon = Icons.wb_sunny;
    }

    return WeatherData(
      temperature: temp, 
      condition: condition, 
      icon: icon
    );
  }

  static List<AlertData> getWeeklyAlerts(String location) {
    final int hash = location.toLowerCase().hashCode;
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    final List<Map<String, String>> alertPool = [
      {'alert': 'Ideal Spraying', 'type': 'Good'},
      {'alert': 'Clear Sky', 'type': 'Good'},
      {'alert': 'Moderate Wind', 'type': 'Caution'},
      {'alert': 'High Heat', 'type': 'Caution'},
      {'alert': 'Light Rain', 'type': 'Warning'},
      {'alert': 'Heavy Rain', 'type': 'Warning'},
      {'alert': 'Cloudy Day', 'type': 'Good'},
    ];

    return List.generate(7, (i) {
      final alertIndex = (hash + i) % alertPool.length;
      return AlertData(
        day: days[i],
        alert: alertPool[alertIndex]['alert']!,
        type: alertPool[alertIndex]['type']!,
      );
    });
  }
}
