// import 'article_model.dart';
// import 'user_model.dart';

// class HomeModel {
//   final List<UserModel> userList;
//   final ArticleModel article;
//   HomeModel(
//     {
//     this.userList,
//     this.article
//   });

//   factory HomeModel.fromJson(Map<String, dynamic> json) {
//     var userListJson = json['userList'] as List;
//     List<UserModel> userList =
//         userListJson.map((i) => UserModel.fromJson(i)).toList();
//     return HomeModel(
//       userList: userList,
//       article: ArticleModel.fromJson(json['config']),
//     );
//   }
// }
