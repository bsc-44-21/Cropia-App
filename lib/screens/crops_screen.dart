import 'package:flutter/material.dart';
import '../widgets/crops/calendar_strip.dart';
import '../widgets/crops/activity_card.dart';
import '../widgets/shared/section_title.dart';

class CropsScreen extends StatelessWidget {
  const CropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Management', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CalendarStrip(),
            SizedBox(height: 24),
            SectionTitle(title: 'Today\'s Activities'),
            SizedBox(height: 12),
            ActivityCard(
              title: 'Apply Fertilizer',
              subtitle: 'Corn Field A',
              time: '10:00 AM',
              icon: Icons.science,
              color: Colors.purple,
            ),
            ActivityCard(
              title: 'Inspect for Pests',
              subtitle: 'Tomato Plot 1',
              time: '02:00 PM',
              icon: Icons.pest_control,
              color: Colors.red,
            ),
            SizedBox(height: 24),
            SectionTitle(title: 'Upcoming'),
            SizedBox(height: 12),
            ActivityCard(
              title: 'Harvesting',
              subtitle: 'Wheat Field B',
              time: 'Tomorrow',
              icon: Icons.agriculture,
              color: Colors.orange,
            ),
            ActivityCard(
              title: 'Irrigation',
              subtitle: 'Corn Field A',
              time: 'Wed, 14th',
              icon: Icons.water_drop,
              color: Colors.blue,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green.shade600,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
