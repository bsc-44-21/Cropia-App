import 'package:flutter/material.dart';
import '../../models/field_model.dart';
import '../../models/crop_data.dart';
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
    final CropData cropData = CropData.getFor(field.cropType);
    final int daysSince = DateTime.now().difference(field.plantingTime).inDays;
    
    // Growth Progress
    final double progress = (daysSince / cropData.durationDays).clamp(0.0, 1.0);
    
    // Revenue Estimation
    final double estimatedYield = field.sizeInAcres * cropData.yieldPerAcre;
    final double estimatedRevenue = estimatedYield * cropData.pricePerUnit;
    final String revenueFormatted = estimatedRevenue >= 1000000 
        ? 'k${(estimatedRevenue / 1000000).toStringAsFixed(1)}M'
        : 'k${(estimatedRevenue / 1000).toStringAsFixed(0)}K';

    // Next Task Logic
    final nextActivityIndex = field.activities.indexWhere((a) => !a.isCompleted);
    final nextActivity = nextActivityIndex != -1 ? field.activities[nextActivityIndex] : null;
    final int? daysToNext = nextActivity?.date.difference(DateTime.now()).inDays;

    // Weather Advisory mocked (Simulating rain forecast)
    // In a real app, this would check a WeatherProvider
    final bool willRainSoon = true; // Mocked for demonstration
    final bool weatherConflict = willRainSoon && 
        (nextActivity?.title.toLowerCase().contains('fertilizer') == true || 
         nextActivity?.title.toLowerCase().contains('spraying') == true);

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Market Price: k${cropData.pricePerUnit.toStringAsFixed(0)} / ${cropData.yieldUnit}',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Est. Revenue: $revenueFormatted',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade100,
                      color: Colors.green.shade500,
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Day $daysSince of ${cropData.durationDays}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                  if (nextActivity != null) ...[
                    const Divider(height: 24),
                    Row(
                      children: [
                        Icon(
                          weatherConflict ? Icons.warning_amber_rounded : Icons.next_plan_outlined,
                          size: 16,
                          color: weatherConflict ? Colors.orange.shade800 : Colors.blue.shade600,
                        ),
                        Expanded(
                          child: Text(
                            weatherConflict 
                              ? 'Advisory: Rain expected. Delay ${nextActivity.title}'
                              : 'Next: ${nextActivity.title} (${daysToNext! <= 0 ? "Today" : "in $daysToNext days"})',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: weatherConflict ? Colors.orange.shade900 : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
