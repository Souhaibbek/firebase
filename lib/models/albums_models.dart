class AlbumsModel {


  late String artistname;
  late String name;
  late String img;

  AlbumsModel({
    required this.name,
    required this.artistname,
    required this.img,
  });

  AlbumsModel.fromJson(Map<String, dynamic>? json) {
    artistname = json!['artistname'];
    name = json['name'];
    img = json['img'];
  }
}
