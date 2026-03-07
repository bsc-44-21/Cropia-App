import 'package:flutter/material.dart';
import '../../models/field_model.dart';
import '../../screens/field_details_screen.dart';

class PremiumFieldCard extends StatelessWidget {
  final FieldModel field;

  const PremiumFieldCard({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMaize = field.cropType.toLowerCase() == 'maize';
    final String price = isMaize ? 'k4,000.00 / KG' : 'k15,000.00 / Crate';
    final int daysSince = DateTime.now().difference(field.plantingTime).inDays;
    
    // Check if any activities are past due and not completed
    final bool hasAlert = field.activities.any((a) => 
      a.date.isBefore(DateTime.now().subtract(const Duration(days: 1))) && !a.isCompleted
    );

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FieldDetailsScreen(fieldId: field.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isMaize ? Colors.yellow.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                isMaize ? Icons.eco : Icons.opacity,
                color: isMaize ? Colors.orange.shade700 : Colors.red.shade700,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        field.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (hasAlert)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.priority_high, color: Colors.white, size: 10),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${field.cropType} • ${field.sizeInAcres} Acres',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Market Price: $price',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.green.shade600),
                      const SizedBox(width: 4),
                      Text(
                        'Day $daysSince of growth',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
