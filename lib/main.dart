import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'providers/scan_provider.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScanProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plant Disease Recognition',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
