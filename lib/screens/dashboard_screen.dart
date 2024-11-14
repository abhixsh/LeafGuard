import 'package:flutter/material.dart';
import 'package:leafguard/screens/about_screen.dart';
import 'package:leafguard/screens/scan_screen.dart'; // Fixed import

class DashboardScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    // Dashboard Screen content
    DashboardScreenBody(),
    ScanScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCBE774),
      appBar: AppBar(
        backgroundColor: Color(0xFFCBE774),
        title: Center(
          child: Image.asset('assets/images/Logo1.png'),
        ),
      ),
      body: _screens[_selectedIndex], // Dynamically display selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Highlight the selected item
        onTap: _onItemTapped, // Handle navigation
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}

class DashboardScreenBody extends StatelessWidget {
  Widget _buildDetectionCard(String title, String date, String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(date),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Image.asset('assets/images/Home_1.png'),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Leaf Algae Detection",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8AB92D),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDetectionCard(
                    "Algae Infection Detected",
                    "2024-10-20",
                    'assets/images/Home_2.png',
                  ),
                  const SizedBox(height: 10),
                  _buildDetectionCard(
                    "No Disease Detected",
                    "2024-10-22",
                    'assets/images/Home_3.png',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
