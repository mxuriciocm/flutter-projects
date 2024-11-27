class FavoriteModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'image': image,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      species: map['species'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
