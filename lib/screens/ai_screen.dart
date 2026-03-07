import 'package:flutter/material.dart';

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
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildSectionTitle('Ask AI Assistant'),
            const SizedBox(height: 12),
            _buildAiPrompts(),
            const SizedBox(height: 32),
            _buildSectionTitle('Knowledge Center'),
            const SizedBox(height: 12),
            _buildKnowledgeCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Ask about crops, pests, fertilizers...',
        prefixIcon: const Icon(Icons.search, color: Colors.green),
        suffixIcon: const Icon(Icons.mic, color: Colors.green),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
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

  Widget _buildAiPrompts() {
    final prompts = [
      {'icon': Icons.calendar_month, 'text': 'Best planting time', 'color': Colors.blue},
      {'icon': Icons.science, 'text': 'Fertilizer advice', 'color': Colors.purple},
      {'icon': Icons.pest_control, 'text': 'Pest prevention', 'color': Colors.red},
      {'icon': Icons.agriculture, 'text': 'Harvest timing', 'color': Colors.orange},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: prompts.length,
      itemBuilder: (context, index) {
        final prompt = prompts[index];
        return Container(
          decoration: BoxDecoration(
            color: (prompt['color'] as MaterialColor).shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: (prompt['color'] as MaterialColor).shade100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(prompt['icon'] as IconData, color: (prompt['color'] as MaterialColor).shade700, size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  prompt['text'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: (prompt['color'] as MaterialColor).shade900,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKnowledgeCards() {
    return Column(
      children: [
        _buildArticleCard('How to control Armyworms', 'Pest Control • 5 min read', Icons.bug_report, Colors.green),
        _buildArticleCard('Maximizing Maize Yield', 'Farming Guide • 8 min read', Icons.eco, Colors.green),
        _buildArticleCard('Drip Irrigation Setup', 'Tutorial • Video', Icons.play_circle_fill, Colors.green),
      ],
    );
  }

  Widget _buildArticleCard(String title, String subtitle, IconData icon, MaterialColor color) {
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
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color.shade700, size: 32),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Text('Read more...'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}
