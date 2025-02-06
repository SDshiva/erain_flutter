import 'owner_model.dart';

class Repo {
  final int id;
  final String name;
  final String description;
  final DateTime updatedAt;
  final Owner owner;

  Repo({
    required this.id,
    required this.name,
    required this.description,
    required this.updatedAt,
    required this.owner,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'No description',
      updatedAt: DateTime.parse(json['updated_at']),
      owner: Owner.fromJson(json['owner']),
    );
  }
}
