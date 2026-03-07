import 'package:flutter/material.dart';
import '../widgets/detect/camera_placeholder.dart';
import '../widgets/detect/action_buttons.dart';
import '../widgets/detect/scan_result_card.dart';

class DetectScreen extends StatelessWidget {
  const DetectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Detection', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Identify Pests & Diseases',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Take a photo of the affected plant to get an AI diagnosis and treatment plan.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const CameraPlaceholder(),
            const SizedBox(height: 32),
            const ActionButtons(),
            const SizedBox(height: 48),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recent Scans',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const ScanResultCard(
                  disease: 'Tomato Leaf Blight',
                  location: 'Found on Tomato Plot 1',
                  risk: 'High Risk',
                  color: Colors.red,
                ),
                const ScanResultCard(
                  disease: 'Healthy Crop',
                  location: 'Maize Field A',
                  risk: 'No Action Needed',
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
