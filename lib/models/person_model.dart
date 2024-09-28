class PersonModel {
  final int id;
  final String? name;
  final String? image;
  bool isFavorite;

  PersonModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFavorite = false,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      image: json['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['profile_path']}'
          : 'https://via.placeholder.com/150',
      isFavorite: false,
    );
  }
}
