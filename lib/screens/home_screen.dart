import 'package:flutter/material.dart';
import '../widgets/home/greeting_widget.dart';
import '../widgets/home/weather_card.dart';
import '../widgets/home/farm_summary.dart';
import '../widgets/home/upcoming_activities.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cropia', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            GreetingWidget(),
            SizedBox(height: 24),
            WeatherCard(),
            SizedBox(height: 24),
            FarmSummary(),
            SizedBox(height: 24),
            UpcomingActivities(),
          ],
        ),
      ),
    );
  }
}
