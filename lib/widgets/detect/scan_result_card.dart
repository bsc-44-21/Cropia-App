import 'package:flutter/material.dart';

class ScanResultCard extends StatelessWidget {
  final String disease;
  final String location;
  final String risk;
  final MaterialColor color;

  const ScanResultCard({
    super.key,
    required this.disease,
    required this.location,
    required this.risk,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(color == Colors.green ? Icons.check_circle : Icons.warning, color: color.shade700),
        ),
        title: Text(disease, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(location),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            risk,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
