import 'package:appdemo/common/style.dart';
import 'package:appdemo/model/list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:like_button/like_button.dart';

class ChannelPage extends StatefulWidget{
  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage>  with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController _scrollViewController;
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
    this.tabController = TabController(length: 4, vsync: this);
  }
  _listBuilder(List list){
    return Container(
      margin:EdgeInsets.only(top:55),
      child:ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return Container(
          width: Style.screenWidth*0.6,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red,width: 1),
            borderRadius:BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:<Widget>[
              Text(
                list[index].text,
                style: TextStyle(
                  color:Colors.red,
                ),
              ),
              LikeButton(
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.stars,
                    color: isLiked ? Colors.red : Colors.orange,
                  );
                },
              )
            ]
          ),
        );
      }
    )
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
            _listBuilder(articles),
            _listBuilder(articles),
            _listBuilder(articles),
            _listBuilder(articles),
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
