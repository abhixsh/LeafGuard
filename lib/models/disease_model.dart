import 'dart:convert';

class Disease {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final List<String> symptoms;
  final List<String> treatments;
  final List<String> preventiveTips;
  final List<String> commonSymptoms;

  Disease({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.symptoms,
    required this.treatments,
    required this.preventiveTips,
    required this.commonSymptoms,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      symptoms: List<String>.from(json['symptoms']),
      treatments: List<String>.from(json['treatments']),
      preventiveTips: List<String>.from(json['preventiveTips']),
      commonSymptoms: List<String>.from(json['commonSymptoms']),
    );
  }
}

class DiseaseData {
  List<Disease> diseases = [];

  Future<void> loadFromJsonString(String jsonString) async {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> jsonList = jsonMap['diseases'];
    diseases = jsonList.map((json) => Disease.fromJson(json)).toList();
  }
}
