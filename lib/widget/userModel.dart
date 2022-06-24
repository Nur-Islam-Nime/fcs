class UserModel {

  late String profileImage;


  UserModel({

    required this.profileImage,

  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(

      profileImage: map['profileImage'],

    );
  }
}