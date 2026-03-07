import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/field_model.dart';
import '../models/crop_data.dart';
import '../providers/field_provider.dart';
import 'field_form_screen.dart';
import '../widgets/fields/field_weather_header.dart';
import '../widgets/fields/weekly_alerts_card.dart';

class FieldDetailsScreen extends StatelessWidget {
  final String fieldId;

  const FieldDetailsScreen({super.key, required this.fieldId});

  @override
  Widget build(BuildContext context) {
    // We listen to changes so if we edit the field, this screen updates
    final field = context.watch<FieldProvider>().fields.firstWhere(
      (f) => f.id == fieldId, 
      orElse: () => FieldModel(id: '', name: '', location: '', sizeInAcres: 0, cropType: '', plantingTime: DateTime.now(), activities: [])
    );
    
    final CropData cropData = CropData.getFor(field.cropType);
    final double estimatedYield = field.sizeInAcres * cropData.yieldPerAcre;
    final double estimatedRevenue = estimatedYield * cropData.pricePerUnit;
    
    // Automatically pop back if the field was deleted 
    if (field.id.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(field.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FieldFormScreen(existingField: field)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Field'),
                  content: Text('Are you sure you want to delete ${field.name}?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        context.read<FieldProvider>().deleteField(field.id);
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldWeatherHeader(location: field.location),
            const WeeklyAlertsCard(),
            const SizedBox(height: 24),
            const Text(
              'Field Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.location_on, 'Location', field.location, Colors.blue),
                    const Divider(height: 24),
                    _buildInfoRow(Icons.square_foot, 'Size', '${field.sizeInAcres} Acres', Colors.orange),
                    const Divider(height: 24),
                    _buildInfoRow(Icons.eco, 'Crop Type', '${field.cropType} (k${cropData.pricePerUnit.toStringAsFixed(0)} / ${cropData.yieldUnit})', Colors.green),
                    const Divider(height: 24),
                    _buildInfoRow(Icons.analytics_outlined, 'Est. Yield', '${estimatedYield.toStringAsFixed(0)} ${cropData.yieldUnit}', Colors.teal),
                    const Divider(height: 24),
                    _buildInfoRow(Icons.payments_outlined, 'Est. Revenue', 'k${estimatedRevenue.toStringAsFixed(2)}', Colors.indigo),
                    const Divider(height: 24),
                    _buildInfoRow(
                      Icons.calendar_today, 
                      'Planting Time', 
                      '${field.plantingTime.year}-${field.plantingTime.month.toString().padLeft(2, '0')}-${field.plantingTime.day.toString().padLeft(2, '0')}', 
                      Colors.purple
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Crop Schedule',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            if (field.activities.isEmpty)
              const Text('No activities scheduled.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: field.activities.length,
                itemBuilder: (context, index) {
                  final activity = field.activities[index];
                  final isPastDue = activity.date.isBefore(DateTime.now().subtract(const Duration(days: 1))) && !activity.isCompleted;
                  
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isPastDue ? Colors.red.shade200 : Colors.grey.shade200,
                        width: isPastDue ? 2 : 1,
                      ),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: activity.isCompleted,
                        activeColor: Colors.green,
                        onChanged: (bool? value) {
                          context.read<FieldProvider>().toggleActivityCompletion(field.id, index);
                        },
                      ),
                      title: Text(
                        activity.title,
                        style: TextStyle(
                          decoration: activity.isCompleted ? TextDecoration.lineThrough : null,
                          color: activity.isCompleted ? Colors.grey : (isPastDue ? Colors.red.shade800 : Colors.black87),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${activity.date.year}-${activity.date.month.toString().padLeft(2, '0')}-${activity.date.day.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          decoration: activity.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: isPastDue
                          ? const Icon(Icons.warning_amber_rounded, color: Colors.red)
                          : null,
                    ),
                  );
                },
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
