class ArtistsModel {
  late String id;
  late String name;
  late String image;

  ArtistsModel({
    required this.name,
    required this.id,
    required this.image,

  });
  ArtistsModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json['name'];
    image = json['image'];
  }
}