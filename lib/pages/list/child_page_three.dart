import 'package:appdemo/model/post_model.dart';
import 'package:appdemo/network/repository/post_repository.dart';
import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_more_list/loading_more_list.dart';

class LoadMoreDemo extends StatefulWidget {
  @override
  _LoadMoreDemoState createState() => _LoadMoreDemoState();
}

class _LoadMoreDemoState extends State<LoadMoreDemo>
    with TickerProviderStateMixin {
  TabController primaryTC;
    final GlobalKey<NestedScrollViewState> _key =
        GlobalKey<NestedScrollViewState>();
    @override
    void initState() {
      primaryTC = TabController(length: 2, vsync: this);
      super.initState();
    }
  
    @override
    void dispose() {
      primaryTC.dispose();
      super.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _buildScaffoldBody(),
      );
    }
  
    Widget _buildScaffoldBody() {
      final double statusBarHeight = MediaQuery.of(context).padding.top;
      final double pinnedHeaderHeight =
          //statusBar height
          statusBarHeight +
              //pinned SliverAppBar height in header
              kToolbarHeight;
      return NestedScrollView(
        key: _key,
        headerSliverBuilder: (BuildContext c, bool f) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              title: const Text('load more list'),
              flexibleSpace: FlexibleSpaceBar(
                  //centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  background: Image.asset(
                    'assets/images/image-1.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ];
        },
        //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
        pinnedHeaderSliverHeightBuilder: () {
          return pinnedHeaderHeight;
        },
        //2.[inner scrollables in tabview sync issue](https://github.com/flutter/flutter/issues/21868)
        innerScrollPositionKeyBuilder: () {
          String index = 'Tab';
  
          index += primaryTC.index.toString();
  
          return Key(index);
        },
        body: Column(
          children: <Widget>[
            TabBar(
              controller: primaryTC,
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2.0,
              isScrollable: false,
              unselectedLabelColor: Colors.grey,
              tabs: const <Tab>[
                Tab(text: 'Tab0'),
                Tab(text: 'Tab1'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: primaryTC,
                children: const <Widget>[
                  TabViewItem(Key('Tab0')),
                  TabViewItem(Key('Tab1')),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
  
class LoadMoreListSource extends LoadingMoreBase<PostModel> {
  int startIndex = 0;
  bool _hasMore = true;
  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool isSuccess = false;
    try {
      List<PostModel> list = await PostRepository.postList(startIndex);
      if (startIndex == 1) {
        this.clear();
      }
      for (var item in list) {
        if(!contains(item)&&hasMore){
          add(item);
        }
      }
      isSuccess=true;
      _hasMore = list.length != 0;
      startIndex ++;
    } catch (exception, stack) {
      print(exception);
      print(stack);
      isSuccess = false;
    }

    print(isSuccess);
    return isSuccess;
  }
}

class PostWidget extends StatelessWidget {
  final PostModel post;
  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}

class TabViewItem extends StatefulWidget {
  const TabViewItem(this.tabKey);
  final Key tabKey;
  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  LoadMoreListSource source;
  @override
  void initState() {
    source = LoadMoreListSource();
    super.initState();
  }

  @override
  void dispose() {
    source?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    final LoadingMoreList<PostModel> child = LoadingMoreList<PostModel>(
      ListConfig<PostModel>(
        itemBuilder: (BuildContext c, PostModel item, int index) {
          return PostWidget(post: item);
        },
        indicatorBuilder:_buildIndicator,
        sourceList: source
      ),
    );

    return NestedScrollViewInnerScrollPositionKeyWidget(
      widget.tabKey, 
      child
    );
  }
  
  Widget _buildIndicator(BuildContext context, IndicatorStatus status){
    Widget widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = SpinKitThreeBounce(
          color: Colors.red,
          size:30
        );
        break;
      case IndicatorStatus.fullScreenBusying:  
        widget = _firstResfresh();
        break; 
      default:
        
    }
    return widget;
  }

  Widget _firstResfresh() {
    return Container(
      //强制撑满
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: SizedBox(
          height: 200.0,
          width: 300.0,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50.0,
                  height: 50.0,
                  child: SpinKitFadingCube(
                    color: Theme.of(context).primaryColor,
                    size: 25.0,
                  ),
                ),
                Container(
                  child: Text('请稍后...'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
