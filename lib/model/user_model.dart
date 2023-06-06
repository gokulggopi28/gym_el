class UserModel {
  final String name;
  final String email;
  final String bio;
  final String profilePic;
  final String createdAt;
  final String phoneNumber;
  final String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.bio,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid
  });
//from map
  factory UserModel.fromMap (Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        bio: map['bio'] ?? '',
        profilePic: map['profilePic'] ?? '',
        createdAt: map['createdAt'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        uid: map['uid'] ?? ''
    );
  }
  //to map
  Map<String, dynamic> toMap(){
    return{
      "name":name,
      "email":email,
      "bio":bio,
      "profilePic":profilePic,
      "createdAt":createdAt,
      "phoneNumber":phoneNumber,
      "uid":uid
    };
  }
}