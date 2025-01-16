import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart';
import '../widgets/disease_result_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Make sure to get the ScanProvider instance
    final scanProvider = Provider.of<ScanProvider>(context);
    final diseaseName = scanProvider.diseaseName;
    final timestamp = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Scan Result',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_rounded, color: Colors.black87),
            onPressed: () {
              // Save to history functionality can be implemented here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Result saved to history')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Result Summary Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(diseaseName).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getStatusIcon(diseaseName),
                              size: 16,
                              color: _getStatusColor(diseaseName),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _getStatusText(diseaseName),
                              style: TextStyle(
                                color: _getStatusColor(diseaseName),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatDateTime(timestamp),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DiseaseResultWidget(diseaseName: diseaseName),
                ],
              ),
            ),

            // Recommendations Section
            _buildSection(
              title: 'Recommendations',
              icon: Icons.lightbulb_outline,
              child: Column(
                children: _getRecommendations(diseaseName).map((rec) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Color(0xFF8AB92D),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            rec,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Prevention Tips Section
            _buildSection(
              title: 'Prevention Tips',
              icon: Icons.shield_outlined,
              child: Column(
                children: _getPreventionTips(diseaseName).map((tip) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.tips_and_updates_outlined,
                          color: Color(0xFF8AB92D),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            tip,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.camera_alt_outlined,
                      label: 'Scan Again',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.history,
                      label: 'View History',
                      onTap: () {
                        // Navigate to history screen
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF8AB92D)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8AB92D),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Color _getStatusColor(String diseaseName) {
    if (diseaseName.toLowerCase().contains('healthy') ||
        diseaseName.toLowerCase().contains('no diseases')) {
      return Colors.green;
    }
    return Colors.red;
  }

  IconData _getStatusIcon(String diseaseName) {
    if (diseaseName.toLowerCase().contains('healthy') ||
        diseaseName.toLowerCase().contains('no diseases')) {
      return Icons.check_circle;
    }
    return Icons.warning;
  }

  String _getStatusText(String diseaseName) {
    if (diseaseName.toLowerCase().contains('healthy') ||
        diseaseName.toLowerCase().contains('no diseases')) {
      return 'Healthy';
    }
    return 'Disease Detected';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  List<String> _getRecommendations(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'fusarium wilt':
        return [
          'Isolate affected plants to prevent spread',
          'Remove and dispose of infected plants',
          'Apply fungicides if needed',
        ];
      case 'early blight':
        return [
          'Prune affected leaves',
          'Improve plant spacing for better airflow',
          'Use resistant varieties if available',
        ];
      case 'leaf spot disease':
        return [
          'Remove infected leaves from plants',
          'Water plants at the base to avoid leaf wetting',
          'Apply fungicides if necessary',
        ];
      default:
        return [
          'Consult a plant expert for further assistance',
        ];
    }
  }

  List<String> _getPreventionTips(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'fusarium wilt':
        return [
          'Ensure proper drainage in the soil',
          'Avoid overwatering',
          'Rotate crops to reduce soilborne pathogens',
        ];
      case 'early blight':
        return [
          'Inspect plants regularly for early signs of disease',
          'Provide good air circulation around plants',
          'Remove fallen leaves from the soil',
        ];
      case 'leaf spot disease':
        return [
          'Avoid overhead watering',
          'Prune affected parts to reduce the spread of spores',
          'Apply appropriate fungicides to prevent further infections',
        ];
      default:
        return [
          'Keep the garden clean and free from debris',
          'Check plants regularly for early symptoms of diseases',
        ];
    }
  }
}
