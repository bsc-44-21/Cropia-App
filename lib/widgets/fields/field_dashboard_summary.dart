import 'package:flutter/material.dart';

class FieldDashboardSummary extends StatelessWidget {
  final int totalFields;
  final double totalAcreage;
  final int maizeCount;
  final int tomatoCount;

  const FieldDashboardSummary({
    super.key,
    required this.totalFields,
    required this.totalAcreage,
    required this.maizeCount,
    required this.tomatoCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Field Summary',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem(
                context,
                Icons.landscape,
                totalFields.toString(),
                'Total Fields',
                Colors.green,
              ),
              _buildSummaryItem(
                context,
                Icons.square_foot,
                totalAcreage.toStringAsFixed(1),
                'Acres',
                Colors.orange,
              ),
              _buildSummaryItem(
                context,
                Icons.eco,
                '$maizeCount/$tomatoCount',
                'M/T Ratio',
                Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
