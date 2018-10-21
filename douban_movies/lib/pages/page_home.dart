import 'package:flutter/material.dart';
import 'package:douban_movies/res/value_string.dart';
import 'package:douban_movies/data/bean_move_list.dart';
import 'package:douban_movies/net/http.dart';
import 'package:douban_movies/pages/page_detail.dart';


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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  //获取电影列表
  loadData() async {
    var datas = await HttpUtils.get(HttpUtils.URL_GET_MOVIE_LIST);
    MovieList moveList = new MovieList(datas);
    _subjects = moveList.subjects;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
          itemCount: _subjects.length,
          itemBuilder: (context, i) {
            if (i.isOdd) return new Divider();
            int index=i~/2;
            return new MoveItem(_subjects[index]);
          },
      ),
    );
  }
}

class MoveItem extends StatelessWidget {

  final subject subjectData;

  MoveItem(this.subjectData);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new DetailPage(subjectData)),
        );
      },
      child: new Row(
        children: <Widget>[
          new Image.network(
              subjectData.images.medium,
              width: 100.0,
              height: 150.0
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 10.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: double.infinity,
                    child: new Text(
                      subjectData.title,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new StarItem(int.parse(subjectData.rating.stars)),
                      new Text('${subjectData.rating.average}')
                    ],
                  ),

                  new Container(
                    width: double.infinity,
                    child: new Text(
                      '${MovieList.getDetailDesc(subjectData)}',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarItem extends StatelessWidget {
  final int _startCount;

  StarItem(this._startCount);

  @override
  Widget build(BuildContext context) {
    return getStarView(_startCount);
  }
}

getStarView(int starts) {
  //获取半实心Start的数量
  int emptyStarCount = starts % 10 == 0 ? 0 : 1;
  //获取实心Start的数量
  int fullStartCount = starts~/10;


  List<Widget> starList = <Widget>[];

  for (var i = 0; i < fullStartCount; i++) {
    starList.add(new Icon(Icons.star,color: Colors.yellow,));
  }

  if (emptyStarCount != 0) {
    starList.add(new Icon(Icons.star_half,color: Colors.yellow));
  }

  return new Row(
    children: starList,
  );
}