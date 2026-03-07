import 'package:flutter/material.dart';

class PriceList extends StatelessWidget {
  const PriceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPriceItem('Maize', 'MWK 450', '+2.5%', true),
        _buildPriceItem('Soybeans', 'MWK 900', '-1.2%', false),
        _buildPriceItem('Groundnuts', 'MWK 1200', '+5.0%', true),
        _buildPriceItem('Tomatoes', 'MWK 800', '0.0%', null),
      ],
    );
  }

  Widget _buildPriceItem(String crop, String price, String change, bool? isUp) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade50,
          child: Text(crop[0], style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold)),
        ),
        title: Text(crop, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isUp != null)
                  Icon(
                    isUp ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 12,
                    color: isUp ? Colors.green : Colors.red,
                  ),
                Text(
                  change,
                  style: TextStyle(
                    fontSize: 12,
                    color: isUp == null ? Colors.grey : (isUp ? Colors.green : Colors.red),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
