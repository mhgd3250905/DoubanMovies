import 'package:flutter/material.dart';
import 'package:douban_movies/res/value_string.dart';
import 'package:douban_movies/data/bean_move_list.dart';
import 'package:douban_movies/net/http.dart';
import 'package:douban_movies/pages/detail/page_detail.dart';
import 'package:transparent_image/transparent_image.dart';
import 'views/StartsView.dart';
import 'package:douban_movies/pages/views/ClipImageView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: AppStrings.AppName,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(AppStrings.HomePageAppBarTitle),
        ),
        body: new HomeContent(),
      ),
    );
  }
}

/**
 * 创建显示在首页的内容
 */
class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<subject> _subjects = new List();
  ScrollController _scrollController = new ScrollController();
  int start = 0;
  int limit = 25;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
    _loadData();
  }

  //获取电影列表
  Future<Null> _loadData() async {
    page = 0;
    var datas = await HttpUtils.get(HttpUtils.URL_GET_MOVIE_LIST, map: {
      'apikey': HttpUtils.URL_API_KEY,
      'udid': HttpUtils.URL_UDID,
      'city': '上海',
      'client': '',
      'start': start + page * limit,
      'count': limit
    });
    MovieList moveList = new MovieList(datas);
    _subjects = moveList.subjects;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: new Container(
        child: new ListView.builder(
          controller: _scrollController,
          itemCount: _subjects.length,
          itemBuilder: (context, i) {
            if (i.isOdd) return new Divider();
            int index = i ~/ 2;
            return new MoveItem(_subjects[index]);
          },
        ),
      ),
      onRefresh: _loadData,
    );
  }

  void _getMore() async {
    page++;
    print('$page');
    var datas = await HttpUtils.get(HttpUtils.URL_GET_MOVIE_LIST,
        map: {'start': start + page * limit, 'count': limit});
    MovieList moveList = new MovieList(datas);
    _subjects.addAll(moveList.subjects);
    setState(() {});
  }
}

class MoveItem extends StatelessWidget {
  final subject subjectData;

  MoveItem(this.subjectData);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new DetailPage(subjectData)),
        );
      },
      child: new Row(
        children: <Widget>[
          new Container(
            width: 110.0,
            padding: EdgeInsets.only(left: 10.0),
            //使用图片渐入框架
            child: ClipImageView(subjectData.images.medium,
                new BorderRadius.circular(4.0)),
          ),
          new Expanded(
            child: new Container(
              height: 150.0,
              padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: double.infinity,
                    child: new Text(
                      subjectData.title,
                      style: new TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  getRatingItem(subjectData),
                  new Container(
                    margin: new EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    child: new Text(
                      '${MovieList.getDetailDesc(subjectData)}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
//                  new Expanded(
//                    child: new Container(
//                      padding: new EdgeInsets.only(top:10.0),
//                      child: new CastsView(subjectData.casts),
//                    ),
//                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getRatingItem(subject subjectData) {
    return int.parse(subjectData.rating.stars) == 0 ?
    new Container(
      width: double.infinity,
      margin: new EdgeInsets.only(top: 10.0),
      child: Text(
          '暂无评分',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
        ),
      ),
    )
        : new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Row(
        children: <Widget>[
          new StarItem(int.parse(subjectData.rating.stars), 15.0,
              Colors.orange[300], true),
          new Container(
            margin: EdgeInsets.only(left: 5.0),
            child: new Text(
              '${subjectData.rating.average}',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CastsView extends StatelessWidget {
  final List<cast> casts;

  CastsView(this.casts);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return casts == null
        ? new Container()
        : new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: casts.length,
      itemBuilder: (context, i) {
        return new Column(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only(
                  left: i != 0 ? 10.0 : 0.0, top: 5.0),
              child: new ClipOval(
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  fit: BoxFit.fitWidth,
                  image: casts[i].avatars.small,
                  height: 45.0,
                  width: 45.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
