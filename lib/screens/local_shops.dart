import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocalShopsPage extends StatelessWidget {
  const LocalShopsPage({Key? key}) : super(key: key);

  Future<void> _launchMaps(String location) async {
    // Encode the location query parameter properly
    final encodedLocation = Uri.encodeComponent(location);
    final Uri googleMapsUri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$encodedLocation");

    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch maps for location: $location');
      }
    } catch (e) {
      debugPrint('Error launching maps: $e');
    }
  }

  Future<void> _launchCall(String phoneNumber) async {
    final Uri telUri = Uri.parse("tel:$phoneNumber");
    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        debugPrint('Could not launch phone call for: $phoneNumber');
      }
    } catch (e) {
      debugPrint('Error launching phone call: $e');
    }
  }

  Widget _buildShopCard({
    required String name,
    required String location,
    required String phoneNumber,
    required String description,
    required List<String> products,
    required String openHours,
    required String district,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
        ),
        subtitle: Text(
          district,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Color(0xFF8AB92D)),
                    const SizedBox(width: 8),
                    Text(
                      openHours,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "Available Products:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8AB92D),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: products
                      .map((product) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8AB92D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product,
                      style: const TextStyle(
                        color: Color(0xFF8AB92D),
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _launchMaps(location),
                        icon: const Icon(Icons.location_on),
                        label: const Text("Directions"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8AB92D),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _launchCall(phoneNumber),
                        icon: const Icon(Icons.phone),
                        label: const Text("Call"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8AB92D),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8AB92D),
        elevation: 0,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF8AB92D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Find Plant Medicine Shops",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Discover trusted local shops for plant medicines and treatments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _buildShopCard(
                  name: "Green Life Agro Center",
                  location: "123 Galle Road, Colombo 03",
                  phoneNumber: "+94112345678",
                  description:
                  "Leading agricultural and plant medicine supplier in Colombo with over 20 years of experience.",
                  district: "Colombo",
                  openHours: "Mon-Sat: 8:30 AM - 6:30 PM",
                  products: [
                    "Fungicides",
                    "Organic Pesticides",
                    "Plant Growth Hormones",
                    "Soil Treatments",
                    "Bio Fertilizers"
                  ],
                ),
                _buildShopCard(
                  name: "Kandy Plant Care Center",
                  location: "45 Peradeniya Road, Kandy",
                  phoneNumber: "+94812345678",
                  description:
                      "Specialized in organic and traditional plant medicines, serving the Kandy region.",
                  district: "Kandy",
                  openHours: "Mon-Sat: 9:00 AM - 6:00 PM",
                  products: [
                    "Herbal Pesticides",
                    "Natural Fungicides",
                    "Organic Fertilizers",
                    "Plant Tonics",
                    "Root Treatments"
                  ],
                ),
                _buildShopCard(
                  name: "Galle Agri Solutions",
                  location: "78 Main Street, Galle",
                  phoneNumber: "+94912345678",
                  description:
                      "One-stop shop for all plant healthcare needs in the Southern Province.",
                  district: "Galle",
                  openHours: "Mon-Sat: 8:00 AM - 7:00 PM",
                  products: [
                    "Chemical Fungicides",
                    "Bio Pesticides",
                    "Plant Nutrients",
                    "Leaf Treatments",
                    "Soil Enhancers"
                  ],
                ),
                _buildShopCard(
                  name: "Jaffna Agro Care",
                  location: "34 Hospital Road, Jaffna",
                  phoneNumber: "+94212345678",
                  description:
                      "Trusted supplier of plant medicines and agricultural solutions in Northern Province.",
                  district: "Jaffna",
                  openHours: "Mon-Sat: 8:30 AM - 5:30 PM",
                  products: [
                    "Organic Solutions",
                    "Plant Medicine Kits",
                    "Growth Promoters",
                    "Disease Control Products",
                    "Eco-friendly Pesticides"
                  ],
                ),
                _buildShopCard(
                  name: "Ratnapura Plant Health Center",
                  location: "56 New Town, Ratnapura",
                  phoneNumber: "+94452345678",
                  description:
                      "Specializing in treatments for gem-mining area plants and local species.",
                  district: "Ratnapura",
                  openHours: "Mon-Sat: 9:00 AM - 6:00 PM",
                  products: [
                    "Local Medicines",
                    "Traditional Remedies",
                    "Organic Treatments",
                    "Soil Conditioners",
                    "Plant Protection Products"
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
