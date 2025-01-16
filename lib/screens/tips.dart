import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({Key? key}) : super(key: key);

  static const Color primaryGreen = Color(0xFF8AB92D);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: primaryGreen,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryGreen,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "Make the most of your gardening experience with these helpful tips",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Main Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Plant Care Guide", Icons.eco),
                    const SizedBox(height: 16),
                    _buildTipsList(const [
                      TipItem(
                        icon: Icons.water_drop,
                        title: "Morning Watering",
                        description:
                        "Water plants early in the morning to prevent evaporation",
                      ),
                      TipItem(
                        icon: Icons.eco,
                        title: "Organic Care",
                        description:
                        "Use organic fertilizers for healthier plant growth",
                      ),
                      TipItem(
                        icon: Icons.cut,
                        title: "Regular Trimming",
                        description:
                        "Trim dead leaves and stems regularly for new growth",
                      ),
                      TipItem(
                        icon: Icons.rotate_right,
                        title: "Rotation",
                        description:
                        "Rotate potted plants for even sunlight exposure",
                      ),
                      TipItem(
                        icon: Icons.opacity,
                        title: "Soil Moisture",
                        description:
                        "Check soil moisture before watering to avoid overwatering",
                      ),
                      TipItem(
                        icon: Icons.layers,
                        title: "Mulching",
                        description:
                        "Use mulch to retain soil moisture and prevent weeds",
                      ),
                      TipItem(
                        icon: Icons.bug_report,
                        title: "Pest Control",
                        description:
                        "Monitor and treat pest infections promptly",
                      ),
                      TipItem(
                        icon: Icons.change_circle,
                        title: "Annual Repotting",
                        description: "Repot plants yearly to refresh the soil",
                      ),
                      TipItem(
                        icon: Icons.menu_book,
                        title: "Research",
                        description:
                        "Research each plant's specific care requirements",
                      ),
                      TipItem(
                        icon: Icons.group_work,
                        title: "Plant Grouping",
                        description: "Group plants with similar watering needs",
                      ),
                    ]),
                    const SizedBox(height: 32),
                    _buildSectionTitle("App Features", Icons.phone_android),
                    const SizedBox(height: 16),
                    _buildTipsList([
                      const TipItem(
                        icon: Icons.favorite,
                        title: "Favorite Diseases",
                        description:
                        "Save and track common plant diseases for quick reference",
                      ),
                      const TipItem(
                        icon: Icons.store,
                        title: "Local Shops",
                        description:
                        "Find and connect with gardening shops in your area",
                      ),
                      const TipItem(
                        icon: Icons.medical_information,
                        title: "Disease Database",
                        description:
                        "Access comprehensive database of plant diseases and treatments",
                      ),
                      const TipItem(
                        icon: Icons.search,
                        title: "Quick Search",
                        description:
                        "Easily search for plants, diseases, and care information",
                      ),
                    ]),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: primaryGreen,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsList(List<TipItem> tips) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: primaryGreen,
                    width: 4,
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    tips[index].icon,
                    color: primaryGreen,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    tips[index].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                subtitle: Text(
                  tips[index].description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TipItem {
  final IconData icon;
  final String title;
  final String description;

  const TipItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}