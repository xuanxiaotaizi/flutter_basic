
import 'package:appdemo/common/http/result_data.dart';
import 'package:appdemo/model/home_model.dart';
import '../common/http/http_manager.dart';
import 'api.dart';

abstract class PostApi {
  ///示例请求
  static Future<HomeModel> getHomeMsg () async {
    String url = '${Api.message}';
    ResultData res = await HttpManager.getInstance().get(url);
   // return HomeModel.fromJson(res);
  }
}