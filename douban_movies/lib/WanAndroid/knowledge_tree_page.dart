import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_tree_bean.dart';
import 'package:douban_movies/WanAndroid/article_page.dart';
import 'package:flutter/material.dart';

final String URL_TREE_LIST = 'http://www.wanandroid.com/tree/json';

class KnowledgeTreePage extends StatefulWidget {
  @override
  _KnowledgeTreePageState createState() => new _KnowledgeTreePageState();
}

class _KnowledgeTreePageState extends State<KnowledgeTreePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildFutureBuilder();
  }

  FutureBuilder<TreeBean> buildFutureBuilder() {
    return new FutureBuilder<TreeBean>(
      builder: (context, AsyncSnapshot<TreeBean> async) {
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
            TreeBean bean = async.data;
            return RefreshIndicator(
              child: new ContentView(bean.nodes),
              onRefresh: () {},
            );
          }
        }
      },
      future: getData(),
    );
  }

  Future<TreeBean> getData() async {
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(URL_TREE_LIST);
    TreeBean bean = TreeBean.fromJson(response.data);
    return bean;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ContentView extends StatelessWidget {
  final List<Node> nodes;

  ContentView(this.nodes);

  void jump2AtriclePage(int id) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemBuilder: (context, i) {
        return new ContentItemView(nodes[i]);
      },
      itemCount: nodes.length,
      scrollDirection: Axis.vertical,
    );
  }
}

class ContentItemView extends StatelessWidget {
  final Node node;

  ContentItemView(this.node);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 0.3,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                node.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10.0,
              ),
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: node.childNodes.map((childNode) {
                  return InkWell(
                    child: new ClipRRect(
                      child: Container(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          childNode.name,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      borderRadius: new BorderRadius.circular(3.0),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new ArticlePage(
                            name: childNode.name,
                            id: childNode.mId,
                            type: ArticleType.NORMAL_ARTICLE,
                          ),
                        ),
                      );
                    },
                  );
//                  return GestureDetector(
//                    child: ,
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        new MaterialPageRoute(
//                            builder: (context) => new ArticlePage(childNode)),
//                      );
//                    },
//                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
