import 'package:flutter/material.dart';

class ScanProvider with ChangeNotifier {
  String _diseaseName = '';

  String get diseaseName => _diseaseName;

  void setDiseaseName(String name) {
    _diseaseName = name;
    notifyListeners();
  }

  Future<void> analyzeImage(String imagePath) async {
    // Call your TensorFlow model here and set the disease name
    // For now, it's mocked:
    setDiseaseName("Powdery Mildew");
  }
}
