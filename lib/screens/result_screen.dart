import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart';
import '../widgets/disease_result_widget.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diseaseName = Provider.of<ScanProvider>(context).diseaseName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Result'),
      ),
      body: DiseaseResultWidget(diseaseName: diseaseName),
    );
  }
}
