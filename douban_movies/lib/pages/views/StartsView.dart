import 'package:flutter/material.dart';

class StarItem extends StatelessWidget {
  final int _startCount;
  final double _starSize;

  StarItem(this._startCount,this._starSize);

  @override
  Widget build(BuildContext context) {
    return getStarView(_startCount,_starSize);
  }
}

getStarView(int starts,double starSize) {
  //获取半实心Start的数量
  int emptyStarCount = starts % 10 == 0 ? 0 : 1;
  //获取实心Start的数量
  int fullStartCount = starts ~/ 10;


  List<Widget> starList = <Widget>[];

  for (var i = 0; i < fullStartCount; i++) {
    starList.add(new Icon(Icons.star, color: Colors.yellow,size: starSize,));
  }

  if (emptyStarCount != 0) {
    starList.add(new Icon(Icons.star_half, color: Colors.yellow,size: starSize,));
  }

  return new Row(
    children: starList,
  );
}