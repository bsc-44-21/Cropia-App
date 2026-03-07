import 'package:flutter/material.dart';
import '../../services/weather_service.dart';

class WeeklyAlertsCard extends StatelessWidget {
  final String location;

  const WeeklyAlertsCard({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final alerts = WeatherService.getWeeklyAlerts(location);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Weekly Alerts & Predictions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              Color bgColor;
              Color iconColor;
              IconData icon;

              switch (alert.type) {
                case 'Good':
                  bgColor = Colors.green.shade50;
                  iconColor = Colors.green.shade600;
                  icon = Icons.check_circle_outline;
                  break;
                case 'Warning':
                  bgColor = Colors.red.shade50;
                  iconColor = Colors.red.shade600;
                  icon = Icons.error_outline;
                  break;
                case 'Caution':
                default:
                  bgColor = Colors.orange.shade50;
                  iconColor = Colors.orange.shade600;
                  icon = Icons.warning_amber_rounded;
                  break;
              }

              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: iconColor.withValues(alpha: 0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      alert.day,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(icon, color: iconColor),
                    const SizedBox(height: 8),
                    Text(
                      alert.alert,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
