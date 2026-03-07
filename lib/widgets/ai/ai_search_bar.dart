import 'package:flutter/material.dart';

class AiSearchBar extends StatelessWidget {
  const AiSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
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
}
