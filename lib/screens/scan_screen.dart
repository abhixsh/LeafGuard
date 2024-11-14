import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart';
import 'result_screen.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});
  ImagePicker get _picker => ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              Image.asset(
                'assets/images/scan_img1.png',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 40), // Add spacing between image and other widgets
              const Text(
                'Scan Leave Here',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(

    onPressed: () async {
            final XFile? image = await _picker.pickImage(source: ImageSource.camera);
            if (image != null) {
              await Provider.of<ScanProvider>(context, listen: false).analyzeImage(image.path);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultScreen()),
              );
            }
          },
                child: const Text('Start Scan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
