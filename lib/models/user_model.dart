class UserModel {
  late String uid;
  late Map favorites;

  UserModel({
    required this.uid,
    required this.favorites,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    uid = json!['uid'];
    favorites = json['favorites'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'favorites': favorites,
    };
  }
}
