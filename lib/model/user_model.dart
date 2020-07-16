
// class UserModel {
//   final String avatar;
//   final String nickname;
//   final String age;
//   final String gender;

//   UserModel(
//       {this.avatar, this.nickname, this.age, this.gender});

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       avatar: json['avatar'],
//       nickname: json['nickname'],
//       age: json['age'],
//       gender: json['gender']
//     );
//   }
// }
class User {
  final int id;
  final String name;
  final String imageUrl;

  User({
    this.id,
    this.name,
    this.imageUrl,
  });
}

