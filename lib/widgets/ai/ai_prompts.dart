import 'package:flutter/material.dart';

class AiPrompts extends StatelessWidget {
  const AiPrompts({super.key});

  @override
  Widget build(BuildContext context) {
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
}
