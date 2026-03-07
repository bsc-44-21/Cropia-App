import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/field_provider.dart';
import 'field_form_screen.dart';
import 'field_details_screen.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.landscape_outlined, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No fields yet',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to create your first field.',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: fieldProvider.fields.length,
            itemBuilder: (context, index) {
              final field = fieldProvider.fields[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                elevation: 0,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade50,
                    child: Icon(Icons.eco, color: Colors.green.shade700),
                  ),
                  title: Text(field.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${field.cropType} • ${field.sizeInAcres} Acres\n${field.location}'),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FieldDetailsScreen(fieldId: field.id),
                      ),
                    );
                  },
                ),
              );
            },
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
