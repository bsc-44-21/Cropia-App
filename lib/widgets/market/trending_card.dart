import 'package:flutter/material.dart';

class TrendingCard extends StatelessWidget {
  const TrendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.orange.shade800),
              const SizedBox(width: 8),
              Text(
                'High Demand for Soybeans',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Soybean prices are expected to rise by 10% in the next two weeks due to increased export demand. Consider holding your harvest if possible.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange.shade900,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
