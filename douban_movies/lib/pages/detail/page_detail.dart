import 'package:flutter/material.dart';
import 'package:douban_movies/res/value_string.dart';
import 'package:douban_movies/pages/page_home.dart';
import 'package:douban_movies/data/bean_move_list.dart' as MoveList;
import 'package:douban_movies/net/http.dart';
import 'package:douban_movies/data/bean_move_detail.dart';
import 'package:douban_movies/pages/views/StartsView.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:douban_movies/pages/detail/MovieTitle/MovieTitle.dart';
import 'package:douban_movies/pages/detail/MovieRating/MovieRating.dart';
import 'package:douban_movies/pages/detail/MovieChannel/MovieChannel.dart';

class DetailPage extends StatelessWidget {
  final subjectItem;

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
    var datas = await HttpUtils.get(
      HttpUtils.URL_GET_MOVIE_DETAIL + id,
      map: {
        'apikey': HttpUtils.URL_API_KEY,
        'udid': HttpUtils.URL_UDID,
        'city': '上海',
        'client': '',
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
    return new Column(
      children: <Widget>[
        new MovieTitleView(detail),
        new MovieRatingView(detail),
        new Container(
          height: 50.0,
          child: new MovieChnnelView(detail),
        ),
        new Expanded(child: new Container(),
        flex: 10,),
      ],
    );
  }
}
