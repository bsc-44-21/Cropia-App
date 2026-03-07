import 'package:flutter/material.dart';
import '../../widgets/knowledge/guide_category_card.dart';
import '../../widgets/knowledge/video_tutorial_card.dart';
import '../../widgets/shared/section_title.dart';
import '../../widgets/ai/article_card.dart'; // Reusing from AI screen

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Knowledge Center', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Learning Categories'),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: const [
                GuideCategoryCard(
                  title: 'Crop Farming Guides',
                  icon: Icons.grass,
                  color: Colors.green,
                  itemCount: '24 Guides',
                ),
                GuideCategoryCard(
                  title: 'Pest Control',
                  icon: Icons.bug_report,
                  color: Colors.red,
                  itemCount: '18 Guides',
                ),
                GuideCategoryCard(
                  title: 'Fertilizer Usage',
                  icon: Icons.science,
                  color: Colors.purple,
                  itemCount: '12 Guides',
                ),
                GuideCategoryCard(
                  title: 'Soil Management',
                  icon: Icons.landscape,
                  color: Colors.brown,
                  itemCount: '8 Guides',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionTitle(title: 'Farming Tutorials'),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  VideoTutorialCard(
                    title: 'How to Setup Drip Irrigation System',
                    duration: '5:30',
                    author: 'AgriTech Expert',
                  ),
                  VideoTutorialCard(
                    title: 'Identifying Common Maize Diseases',
                    duration: '8:45',
                    author: 'Crop.io Labs',
                  ),
                  VideoTutorialCard(
                    title: 'Organic Fertilizer Preparation',
                    duration: '12:10',
                    author: 'Green Farms',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Featured Articles'),
            const SizedBox(height: 16),
            Column(
              children: const [
                ArticleCard(
                  title: 'Top 5 Drought Resistant Crops for 2026',
                  subtitle: 'Farming Trends • 4 min read',
                  icon: Icons.wb_sunny,
                  color: Colors.orange,
                ),
                ArticleCard(
                  title: 'Understanding Soil pH Levels',
                  subtitle: 'Soil Health • 6 min read',
                  icon: Icons.opacity,
                  color: Colors.blue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
