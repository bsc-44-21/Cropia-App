import 'package:flutter/material.dart';
import '../widgets/ai/ai_search_bar.dart';
import '../widgets/ai/ai_prompts.dart';
import '../widgets/ai/article_card.dart';
import '../widgets/shared/section_title.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Farming AI', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AiSearchBar(),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Ask AI Assistant'),
            const SizedBox(height: 12),
            const AiPrompts(),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Knowledge Center'),
            const SizedBox(height: 12),
            Column(
              children: const [
                ArticleCard(
                  title: 'How to control Armyworms',
                  subtitle: 'Pest Control • 5 min read',
                  icon: Icons.bug_report,
                  color: Colors.green,
                ),
                ArticleCard(
                  title: 'Maximizing Maize Yield',
                  subtitle: 'Farming Guide • 8 min read',
                  icon: Icons.eco,
                  color: Colors.green,
                ),
                ArticleCard(
                  title: 'Drip Irrigation Setup',
                  subtitle: 'Tutorial • Video',
                  icon: Icons.play_circle_fill,
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
