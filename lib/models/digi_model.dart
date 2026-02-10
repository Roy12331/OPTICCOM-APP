class DigiModel {
  final int id;
  final String name;
  final String image;
  final String href;

  DigiModel({
    required this.id,
    required this.name,
    required this.image,
    required this.href,
  });

  // Factory: Convierte el mapa (JSON) que llega de Internet a un objeto Dart
  factory DigiModel.fromJson(Map<String, dynamic> json) {
    return DigiModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      image: json['image'] ?? '',
      href: json['href'] ?? '',
    );
  }
}
