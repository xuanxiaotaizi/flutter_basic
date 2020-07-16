
//import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'model/counter.dart';

List<SingleChildWidget> providers = [
  ...independentServices
  //...dependentServices,
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<Counter>(
    create: (context) => Counter(1)
  ),
];

/// 需要依赖的model
///
/// UserModel依赖globalFavouriteStateModel
List<SingleChildWidget> dependentServices = [];
