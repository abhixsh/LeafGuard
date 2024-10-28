import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart';
import 'result_screen.dart';

class ScanScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Plant Disease'),
      ),
      body: Center(
        child: ElevatedButton(
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
          child: Text('Scan Plant'),
        ),
      ),
    );
  }
}
