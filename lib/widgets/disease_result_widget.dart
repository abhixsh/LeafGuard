import 'package:flutter/material.dart';

class DiseaseResultWidget extends StatelessWidget {
  final String diseaseName;

  const DiseaseResultWidget({required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Disease Detected:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            diseaseName,
            style: TextStyle(fontSize: 20, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
