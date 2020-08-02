import 'package:appdemo/bloc/post_bloc.dart';
import 'package:appdemo/common/style.dart';
import 'package:appdemo/model/list_model.dart';
import 'package:appdemo/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:like_button/like_button.dart';

class ChannelPage extends StatefulWidget{
  @override
  _ChannelPageState createState() => _ChannelPageState();
}
class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
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
class _ChannelPageState extends State<ChannelPage>  with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController _scrollViewController;
  ScrollController _innerScroll;
  PostBloc _postBloc;
  List<String> images= [
    'assets/images/image-1.jpg',
    'assets/images/image-2.jpg',
    'assets/images/image-3.jpg',
    'assets/images/image-4.jpg',
    'assets/images/image-5.jpg',
  ];
  
  @override
  void initState(){
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _innerScroll = ScrollController(initialScrollOffset: 200.0);
    _innerScroll.addListener(_onScroll);
    this.tabController = TabController(length: 4, vsync: this);
  }
  void _onScroll() {
    final maxScroll = _scrollViewController.position.maxScrollExtent;
    final currentScroll = _scrollViewController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      _postBloc.add(PostFetched());
    }
  }
  _firstResfresh() {
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
 _blocBulider(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial) {
         return _firstResfresh();
        }
        if (state is PostFailure) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is PostSuccess) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            controller: _innerScroll,
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostWidget(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
          );
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder:(BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.white,), 
                  onPressed: null
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.white
                    ), onPressed: null)
                ],
                pinned:true,
                elevation:0,
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Sticky' ,style: TextStyle(color:Colors.white),) ,
                  background: Swiper(
                    itemBuilder: (BuildContext context,int index){
                      return new Image.asset(images[index],fit: BoxFit.cover,);
                    },
                    itemCount: images.length,
                    loop: true,
                    autoplay:true
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
            
              delegate: StickyTabBarDelegate(
                child:  TabBar(
                  controller: this.tabController,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs:<Widget>[
                    Tab(
                      text:'tab-1'
                    ),
                    Tab(
                      text:'tab-2'
                    ),
                    Tab(
                      text:'tab-3'
                    ),
                    Tab(
                      text:'tab-4'
                    )
                  ] 
                )
              )
            ),
          ];
        },
        body: TabBarView(
          controller: this.tabController,
          children: <Widget>[
            _blocBulider(context),
           _blocBulider(context),
            _blocBulider(context),
            _blocBulider(context),
          ],
        ),
      )
    );
  }
}
class StickyTabBarDelegate extends SliverPersistentHeaderDelegate{
  final TabBar child;
  StickyTabBarDelegate({@required this.child});
   @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child:this.child,
      color: Colors.red,
    ); 
  }
 
  @override
  double get maxExtent => this.child.preferredSize.height;
 
  @override
  double get minExtent => this.child.preferredSize.height;
 
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if(shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 背景图
          Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          // 收起头部
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),    // 背景颜色
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, true),    // 返回图标颜色
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        this.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, false),    // 标题颜色
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, true),    // 分享图标颜色
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
