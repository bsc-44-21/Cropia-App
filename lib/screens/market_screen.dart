import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Prices', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMarketSummary(),
            const SizedBox(height: 24),
            _buildSectionTitle('Live Prices (Per Kg)'),
            const SizedBox(height: 12),
            _buildPriceList(),
            const SizedBox(height: 24),
            _buildSectionTitle('Trending Opportunities'),
            const SizedBox(height: 12),
            _buildTrendingCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Local Market',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              const Text(
                'Lilongwe Central',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Change', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildPriceList() {
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

  Widget _buildTrendingCard() {
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
