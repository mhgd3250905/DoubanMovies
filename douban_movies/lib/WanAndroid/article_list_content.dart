import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_article_bean.dart';
import 'package:douban_movies/pages/views/ClipImageView.dart';
import 'package:flutter/material.dart';

import 'article_page.dart';

final String URL_HOME_ARTICLE_LIST =
    'http://www.wanandroid.com/article/list/0/json';

class ArticleListPage extends StatefulWidget {
  final String url;
  final ArticleType type;

  ArticleListPage({this.url, this.type});

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildFutureBuilder();
  }

  FutureBuilder<HomeBean> buildFutureBuilder() {
    return new FutureBuilder<HomeBean>(
      builder: (context, AsyncSnapshot<HomeBean> async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new Text('Waitiing...'),
          );
        }

        if (async.connectionState == ConnectionState.done) {
          debugPrint('done');
          if (async.hasError) {
            return new Center(
              child: new Text('Error:code '),
            );
          } else if (async.hasData) {
            HomeBean bean = async.data;
            return RefreshIndicator(
              child: new ArticleListView(bean.data, widget.type),
              onRefresh: () {},
            );
          }
        }
      },
      future: getData(),
    );
  }

  Future<HomeBean> getData() async {
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(widget.url);
    HomeBean bean = HomeBean.fromJson(response.data);
    return bean;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ArticleListView extends StatelessWidget {
  final HomeListBean data;
  final ArticleType type;

  ArticleListView(this.data, this.type);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.datas.length,
      itemBuilder: (BuildContext context, int i) {
        return new Container(
          margin: EdgeInsets.only(top: i == 0 ? 10.0 : 0),
          child: Column(
            children: <Widget>[
              getContentItem(i),
              new Container(
                margin: EdgeInsets.only(bottom: 10.0),
                color: Colors.grey,
                height: 0.2,
              ),
            ],
          ),
        );
      },
      scrollDirection: Axis.vertical,
    );
  }

  getContentItem(int i) {
    if (data.datas[i].envelopePic == "") {
      return ArticleItemView(data.datas[i]);
    } else {
      return ProjectItemView(data.datas[i]);
    }
  }
}

class ArticleItemView extends StatefulWidget {
  final Data data;

  ArticleItemView(this.data);

  @override
  _ArticleItemViewState createState() => new _ArticleItemViewState();
}

class _ArticleItemViewState extends State<ArticleItemView> {
  bool isCollected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void changeItemCollect() {
    if (isCollected) {
      isCollected = false;
    } else {
      isCollected = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 3.0),
                alignment: Alignment.centerLeft,
                child: new Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                  size: 14.0,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.data.author == null ? "" : widget.data.author,
                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                ),
              ),
              new Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 3.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.data.niceDate == null ? "" : widget.data.niceDate,
                    style: TextStyle(fontSize: 13.0, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              widget.data.title,
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          new Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  widget.data.chapterName,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
              ),
              new Expanded(
                  child: new Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    icon: new Icon(
                      isCollected ? Icons.favorite : Icons.favorite_border,
                      color: isCollected ? Colors.blue : Colors.grey[400],
                      size: 20.0,
                    ),
                    onPressed: () {
                      changeItemCollect();
                    }),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectItemView extends StatefulWidget {
  final Data data;

  ProjectItemView(this.data);

  @override
  _ProjectItemViewState createState() => new _ProjectItemViewState();
}

class _ProjectItemViewState extends State<ProjectItemView> {
  bool isCollected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void changeItemCollect() {
    if (isCollected) {
      isCollected = false;
    } else {
      isCollected = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      alignment: Alignment.centerLeft,
      height: 200.0,
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 5.0),
            width: 100.0,
            child: ClipImageView(
                widget.data.envelopePic, BorderRadius.circular(3.0)),
          ),
          Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: new Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text(
                          widget.data.title,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          alignment: Alignment.topLeft,
                          width: double.infinity,
                          child: Text(
                            widget.data.title,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        widget.data.chapterName,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    new Expanded(
                        child: new Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          icon: new Icon(
                            isCollected
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isCollected ? Colors.blue : Colors.grey[400],
                            size: 20.0,
                          ),
                          onPressed: () {
                            changeItemCollect();
                          }),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
