import 'package:appdemo/cudb/http/http_manager.dart';
import 'package:appdemo/cudb/http/result_data.dart';
import 'package:appdemo/model/post_model.dart';

class PostRepository{
  static Future<List<PostModel>> postList (int startIndex) async {
    List<PostModel> list;
    String url = '/posts?_start=$startIndex&_limit=10';
    ResultData data = await HttpManager.getInstance().get(url);
    print(data);
    list = data.data.map<PostModel>((json) => PostModel.fromJson(json)).toList();

    print(list);
    return list;
  }
}