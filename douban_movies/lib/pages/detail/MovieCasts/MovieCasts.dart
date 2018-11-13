import 'package:flutter/material.dart';
import 'package:douban_movies/data/bean_move_detail.dart';
import 'package:transparent_image/transparent_image.dart';


class MovieCastsView extends StatelessWidget{
  final MovieDetail detail;

  MovieCastsView(this.detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            child: new Text('简介',
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Expanded(
            child: new Row(
              children: <Widget>[
                getCastsView(detail.casts)
              ],
            ),
          ),
        ],
      ),
    );
  }

  getCastsView(List<cast> casts) {
    return new ListView.builder(
      itemCount: casts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,i){
          return new Container(
            child: new ClipRRect(
              child: new FadeInImage.memoryNetwork(
                fit: BoxFit.fitWidth,
                placeholder: kTransparentImage,
                image: detail.images.medium,
              ),
              borderRadius: new BorderRadius.circular(4.0),
            ),
          )
        }
    );

  }


}