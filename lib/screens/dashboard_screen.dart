import 'package:flutter/material.dart';
import 'scan_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanScreen()),
            );
          },
          child: Text('Get Started'),
        ),
      ),
    );
  }
}
