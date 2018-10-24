import 'package:flutter/material.dart';
import 'package:douban_movies/res/value_string.dart';
import 'package:douban_movies/pages/page_home.dart';
import 'package:douban_movies/data/bean_move_list.dart';
import 'package:douban_movies/net/http.dart';
import 'package:douban_movies/data/bean_move_detail.dart';

class DetailPage extends StatelessWidget {

  final subject subjectItem;

  DetailPage(this.subjectItem);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(subjectItem.title),
      ),
      body: new DetailContent(subjectItem.id),
    );
  }

}

class DetailContent extends StatefulWidget {

  final String id;

  DetailContent(this.id);

  @override
  _DetailContentState createState() => _DetailContentState(id);
}

class _DetailContentState extends State<DetailContent> {

  final String id;
  MovieDetail detail;

  _DetailContentState(this.id);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  //获取电影详情
  loadData() async {
    var datas = await HttpUtils.get(HttpUtils.URL_GET_MOVIE_DETAIL + id,
        map: {
          'apikey':HttpUtils.URL_API_KEY,
          'udid':HttpUtils.URL_UDID,
          'city':'上海',
          'client':'',
        },
    );
    detail = new MovieDetail(datas);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: detail == null ? new Container() : new MovieDetial(detail),
    );
  }
}

class MovieDetial extends StatelessWidget {

  final MovieDetail detail;

  MovieDetial(this.detail);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new MovieTitleView(detail),
        new MovieRatingView(detail),
//        new MovieTypeView(detail),
//        new MovieDescView(detail),
      ],
    );
  }
}

class MovieTitleView extends StatelessWidget {

  final MovieDetail detail;

  MovieTitleView(this.detail);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(10.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            child: new Text(
              detail.title,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  height: 150.0,
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.only(top: 10.0)),
                      new Row(
                        children: <Widget>[
                          new StarItem(int.parse(detail.rating.stars)),
                          new Text('${detail.rating.average}'),
                        ],
                      ),
                      new Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10.0),
                        child: new Text(
                          MovieDetail.getDetailDesc(detail),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Image.network(
                  detail.images.medium,
                  width: 100.0,
                  height: 150.0
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieRatingView extends StatelessWidget {

  final MovieDetail detail;

  MovieRatingView(this.detail);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.grey[500],
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      width: double.infinity,
      height: 150.0,
    );
  }
}