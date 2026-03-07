import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/field_model.dart';
import '../providers/field_provider.dart';
import 'field_form_screen.dart';

class FieldDetailsScreen extends StatelessWidget {
  final String fieldId;

  const FieldDetailsScreen({super.key, required this.fieldId});

  @override
  Widget build(BuildContext context) {
    // We listen to changes so if we edit the field, this screen updates
    final field = context.watch<FieldProvider>().fields.firstWhere((f) => f.id == fieldId, orElse: () => FieldModel(id: '', name: '', location: '', sizeInAcres: 0, cropType: '', plantingTime: DateTime.now()));
    
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
            _buildDetailCard(
              icon: Icons.location_on,
              title: 'Location',
              value: field.location,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildDetailCard(
              icon: Icons.square_foot,
              title: 'Size',
              value: '${field.sizeInAcres} Acres',
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            _buildDetailCard(
              icon: Icons.eco,
              title: 'Crop Type',
              value: field.cropType,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildDetailCard(
              icon: Icons.calendar_today,
              title: 'Planting Time',
              value: '${field.plantingTime.year}-${field.plantingTime.month.toString().padLeft(2, '0')}-${field.plantingTime.day.toString().padLeft(2, '0')}',
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({required IconData icon, required String title, required String value, required Color color}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
