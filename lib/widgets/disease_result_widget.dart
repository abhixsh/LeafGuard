import 'package:flutter/material.dart';
import 'dart:ui';

class DiseaseResultWidget extends StatelessWidget {
  final String diseaseName;

  const DiseaseResultWidget({
    Key? key,
    required this.diseaseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Result1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Blurred Overlay
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),

        // Content
        Center(
          child: Container(
            margin: const EdgeInsets.all(50),
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Results Text
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7E89E),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Results',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Detection Result
                Text(
                  diseaseName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}