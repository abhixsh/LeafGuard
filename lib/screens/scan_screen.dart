// scan_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart'; // Ensure ScanProvider is properly defined
import 'result_screen.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    return Scaffold(
      backgroundColor: const Color(0xFFCBE774),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Leaf Scanner',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 30),
            // Main Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Leaf Scanner Animation Area
                      _buildScanArea(
                        context: context,
                        picker: _picker,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Take a clear photo of the leaf',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Tips Section
                      _buildTips(),
                      const SizedBox(height: 30),
                      // Action Buttons
                      _buildActionButtons(context, _picker),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanArea({
    required BuildContext context,
    required ImagePicker picker,
  }) {
    return GestureDetector(
      onTap: () async => _pickImage(context, picker, ImageSource.camera),
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFCBE774),
            width: 2,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.document_scanner_outlined,
            size: 100,
            color: const Color(0xFF8AB92D),
          ),
        ),
      ),
    );
  }

  Widget _buildTips() {
    return Column(
      children: const [
        TipCard(
          icon: Icons.light_mode,
          title: 'Good Lighting',
          description: 'Ensure proper lighting for accurate detection.',
        ),
        TipCard(
          icon: Icons.center_focus_strong,
          title: 'Clear Focus',
          description: 'Keep the leaf in focus and centered.',
        ),
        TipCard(
          icon: Icons.crop_free,
          title: 'Full View',
          description: 'Capture the entire leaf in the frame.',
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ImagePicker picker) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            context: context,
            icon: Icons.camera_alt_rounded,
            label: 'Take Photo',
            source: ImageSource.camera,
            picker: picker,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            context: context,
            icon: Icons.photo_library_rounded,
            label: 'Gallery',
            source: ImageSource.gallery,
            picker: picker,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required ImageSource source,
    required ImagePicker picker,
  }) {
    return ElevatedButton(
      onPressed: () => _pickImage(context, picker, source),
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
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(
    BuildContext context,
    ImagePicker picker,
    ImageSource source,
  ) async {
    try {
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF8AB92D),
            ),
          ),
        );

        await Provider.of<ScanProvider>(context, listen: false)
            .analyzeImage(image.path);

        if (context.mounted) {
          Navigator.pop(context); // Dismiss loading
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ResultScreen()),
          );
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to process the image. Try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class TipCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const TipCard({
    required this.icon,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFCBE774).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF8AB92D)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
