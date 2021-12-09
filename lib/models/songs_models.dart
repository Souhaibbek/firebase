class SongsModel {
  late String id;
  late String name;
  late String artist;
  late String album;

  SongsModel({
    required this.name,
    required this.id,
    required this.artist,
    required this.album,

  });
  SongsModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json['name'];
    artist = json['artist'];
    album = json['album'];
  }
}