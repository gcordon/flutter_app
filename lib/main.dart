import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
// http://www.manongjc.com/detail/12-vygbisoqfuawzjl.html
//https://pub.flutter-io.cn/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'bandou'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  List<BottomNavigationBarItem> bottomObj = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: '书影音',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      label: '小组',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var searchInput = '你有过哪些莫名奇妙的受伤经历？';
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: bottomObj,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black45,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      body: Container(
        // color: Colors.black,
        alignment: const Alignment(0.0, -1),
        child: Column(
          children: [
            // 顶部搜索框
            searchModel(searchInput),
            // tabbar切换
            Expanded(
              // height: 400,
              child: IndexTabBar(),
              // child: BasicPage(),
            )
          ],
        ),
      ),
    );
  }

  Row searchModel(String searchInput) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Container(
          width: 320,
          height: 50,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.only(left: 8, top: 10),
          child: TextField(
            autofocus: true,
            onChanged: (v) {
              print("onChange: $v");
            },
            cursorColor: Colors.white,
            decoration: InputDecoration(
              fillColor: Color(0x30cccccc),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00FF0000),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              border: InputBorder.none,
              hintText: "$searchInput",
              prefixIcon: Icon(
                Icons.search,
              ),
              suffixIcon: Icon(
                Icons.linear_scale_rounded,
              ),
              prefixStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        Container(
          // color: Colors.red,
          // margin: EdgeInsets.only(top: 8, left: 20),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.email_outlined,
                size: 30,
                color: Colors.white70,
              ),
            ],
          ),
        )
      ],
    );
  }
}

// easy refresh 使用例子参考
class BasicPage extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  List<String> addStr = ["a1", "b2", "c3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> str = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EasyRefresh"),
      ),
      body: Center(
        child: new EasyRefresh(
          child: new ListView.builder(
            //ListView的Item
            itemCount: str.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                height: 10.0,
                child: Card(
                  child: new Center(
                    child: new Text(
                      str[index],
                      style: new TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              );
            },
          ),
          onRefresh: () async {
            await new Future.delayed(
              const Duration(seconds: 1),
              () {
                setState(
                  () {
                    str.clear();
                    str.addAll(addStr);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

//首页内容切换
class IndexTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabBar();
}

class _TabBar extends State<IndexTabBar> {
  TabController _controller;
  final List<String> _tabValues = [
    '动态',
    '推荐',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _tabValues.length,
      vsync: ScrollableState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          bottom: TabBar(
            tabs: _tabValues.map(
              (f) {
                return Text(f);
              },
            ).toList(),
            controller: _controller,
            indicatorColor: Colors.green,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.white,
            indicatorWeight: 2.0,
            labelStyle: TextStyle(height: 2),
          ),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _tabValues.map(
          (f) {
            return Container(
              child: Column(
                children: [
                  // douListBox(),
                  // BasicPage()
                  Expanded(
                    child: new EasyRefresh(
                      child: new ListView.builder(
                        //ListView的Item
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return douListBox();
                          // return douListBox();
                        },
                      ),
                      onRefresh: () async {},
                    ),
                  )
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

// 首页文章推荐
class douListBox extends StatelessWidget {
  const douListBox({
    Key key,
  }) : super(key: key);

  void tapThumbUp() {
    print("点击了👍按钮");
  }

  void tapComments() {
    print("点击了评论按钮");
  }

  void tapShare() {
    print("点击了分享按钮");
  }

  @override
  Widget build(BuildContext context) {
    String thumbUpNumber = '99';
    return Container(
      color: Colors.black54,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            color: Colors.black87,
            padding: EdgeInsets.only(
              top: 4,
              left: 8,
              right: 8,
              bottom: 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "asserts/logo.png",
                            ),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '小林子',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: '(cv仔在此)',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '49分前发布',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white30,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.linear_scale_outlined,
                          color: Colors.white30,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 4,
                    left: 8,
                    right: 8,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: '#',
                      style: TextStyle(fontSize: 16.0, color: Colors.green),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: '收到的赠书语',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    // horizontal: 8.0,
                  ),
                  child: Column(
                    children: [
                      // PhotoView(
                      //   imageProvider: AssetImage("asserts/logo.png"),
                      // ),
                      Text(
                        "1920年，女性吸烟还是taboo，美国烟草公司聘请Bernays，力求拓展女性消费群体。Bernays的scenario是把吸烟跟女权结合起来，刚获得投票权没几年的女性很容易被“她们点燃的不是香烟，是自由”激发起情绪，理性败给情绪，Bernays的操作几乎就是如今的情绪化洗脑文案＋水军＋买热搜，效果却出奇的好，直接让lung cancer性别趋向平等了，1920年啊，互联网思维，PR吊炸天。",
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.white12,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //点赞
                        iconWithTextAndTo(
                          tapThumbUp,
                          createArticleIcon(icon: Icons.thumb_up),
                          thumbUpNumber,
                        ),
                        iconWithTextAndTo(
                          tapComments,
                          createArticleIcon(icon: Icons.message_outlined),
                          thumbUpNumber,
                        ),
                        iconWithTextAndTo(
                          tapShare,
                          createArticleIcon(icon: Icons.share_outlined),
                          thumbUpNumber,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Icon createArticleIcon({icon}) {
    return Icon(
      icon,
      color: Colors.white54,
      size: 18,
    );
  }

  // annotation
  GestureDetector iconWithTextAndTo(
    Function onTap,
    Icon iconObj,
    String aboutNum,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          iconObj,
          Text(
            aboutNum,
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
