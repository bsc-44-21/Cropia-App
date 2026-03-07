import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/field_provider.dart';
import 'field_form_screen.dart';
import '../widgets/fields/field_dashboard_summary.dart';
import '../widgets/fields/premium_field_card.dart';

class CropsScreen extends StatelessWidget {
  const CropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Fields', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer<FieldProvider>(
        builder: (context, fieldProvider, child) {
          if (fieldProvider.fields.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.landscape_outlined, size: 80, color: Colors.green.shade200),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'No fields registered',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Start monitoring your farm by adding your first field now.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600, height: 1.5),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const FieldFormScreen()),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Your First Field'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final int maizeCount = fieldProvider.fields.where((f) => f.cropType.toLowerCase() == 'maize').length;
          final int tomatoCount = fieldProvider.fields.where((f) => f.cropType.toLowerCase() == 'tomato').length;
          final double totalAcreage = fieldProvider.fields.fold(0, (sum, field) => sum + field.sizeInAcres);

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              FieldDashboardSummary(
                totalFields: fieldProvider.fields.length,
                totalAcreage: totalAcreage,
                maizeCount: maizeCount,
                tomatoCount: tomatoCount,
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Active Fields',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...fieldProvider.fields.map((field) => PremiumFieldCard(field: field)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FieldFormScreen()),
          );
        },
        backgroundColor: Colors.green.shade600,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
