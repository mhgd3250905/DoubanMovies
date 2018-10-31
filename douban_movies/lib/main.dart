import 'package:flutter/material.dart';
import 'pages/page_home.dart';
import 'package:flutter/rendering.dart';

void main() {
  //设置debugPaintSizeEnabled为true来更直观的调试布局问题
  debugPaintSizeEnabled=false;
  return runApp(new HomePage());
}

