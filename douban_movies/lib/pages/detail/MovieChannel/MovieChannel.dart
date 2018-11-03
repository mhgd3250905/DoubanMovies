import 'package:flutter/material.dart';
import 'package:douban_movies/data/bean_move_detail.dart';
import 'package:douban_movies/pages/views/Chips.dart';

class MovieChnnelView extends StatelessWidget {
  final MovieDetail detail;
  MovieChnnelView(this.detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: new EdgeInsets.all(10.0),
      child: new Container(
        child: new Row(
          children: <Widget>[
            new Text('所属频道'),
            new Padding(padding: new EdgeInsets.only(left: 10.0)),
            getMovieChannelItems(detail),
          ],
        ),
      ),
    );
  }

  ///get movie channel items
  getMovieChannelItems(MovieDetail detail) {
    return new Expanded(
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: detail.tags.length,
        itemBuilder: (context, i) {
          return new Container(
            padding: new EdgeInsets.only(right: 5.0),
            child: new Chip(
              onDeleted: () {
                print('点击了标签！');
              },
              deleteIcon: new Icon(Icons.chevron_right),
              label: new Text(detail.tags[i]),
            ),
          );
        },
      ),
    );
  }
}
