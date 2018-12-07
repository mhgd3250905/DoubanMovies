import 'package:douban_movies/WanAndroid/article_list_content.dart';
import 'package:flutter/material.dart';

final String URL_TREE_ARTICLE_LIST =
    'http://www.wanandroid.com/article/list/0/json?cid=';
final String URL_PROJECT_ARTICLE_LIST =
    'http://www.wanandroid.com/project/list/0/json?cid=';

enum ArticleType {
  NORMAL_ARTICLE,
  PROJECT_ARTICLE,
}

class ArticlePage extends StatelessWidget {
  final String name;
  final int id;
  final ArticleType type;

  ArticlePage({this.name, this.id, this.type});

  @override
  Widget build(BuildContext context) {
    String url = "";
    switch (type) {
      case ArticleType.NORMAL_ARTICLE:
        url = URL_TREE_ARTICLE_LIST + id.toString();
        break;
      case ArticleType.PROJECT_ARTICLE:
        url = URL_PROJECT_ARTICLE_LIST + id.toString();
        break;
    }
    debugPrint(url);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(name),
      ),
      body: ArticleListPage(
        url: url,
        type: type,
      ),
    );
  }
}
