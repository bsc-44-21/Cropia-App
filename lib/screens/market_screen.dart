import 'package:flutter/material.dart';
import '../widgets/market/market_summary.dart';
import '../widgets/market/price_list.dart';
import '../widgets/market/trending_card.dart';
import '../widgets/shared/section_title.dart';

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
          children: const [
            MarketSummary(),
            SizedBox(height: 24),
            SectionTitle(title: 'Live Prices (Per Kg)'),
            SizedBox(height: 12),
            PriceList(),
            SizedBox(height: 24),
            SectionTitle(title: 'Trending Opportunities'),
            SizedBox(height: 12),
            TrendingCard(),
          ],
        ),
      ),
    );
  }
}
