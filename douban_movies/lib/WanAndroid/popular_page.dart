import 'package:dio/dio.dart';
import 'package:douban_movies/WanAndroid/Data/data_navi_bean.dart';
import 'package:flutter/material.dart';

final String URL_NAVI_LIST = 'http://www.wanandroid.com/navi/json';

class PopularPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: SearchTextField(),
        automaticallyImplyLeading: false,
      ),
      body: PopularContentView(),
    );
  }
}




class SearchTextField extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: TextField(
        autofocus: false,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '搜索一下吧.',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: GestureDetector(
            child: Icon(Icons.arrow_back,color: Colors.blue,),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          suffixIcon: Icon(Icons.search,color: Colors.blue,)
        ),
      ),
    );
  }
}

class PopularContentView extends StatefulWidget {

  @override
  _PopularContentViewState createState() => _PopularContentViewState();
}

class _PopularContentViewState extends State<PopularContentView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildFutureBuilder();
  }


  FutureBuilder<NaviBean> buildFutureBuilder() {
    return new FutureBuilder<NaviBean>(
      builder: (context, AsyncSnapshot<NaviBean> async) {
        if (async.connectionState == ConnectionState.active
            || async.connectionState == ConnectionState.waiting) {
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
            NaviBean bean = async.data;
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

  Future<NaviBean> getData() async {
    debugPrint('getData');
    var dio = new Dio();
    Response response = await dio.get(
        URL_NAVI_LIST);
    NaviBean bean = NaviBean.fromJson(response.data);
    return bean;
  }
}

class ContentView extends StatelessWidget {
  final List<NaviNode> nodes;

  ContentView(this.nodes);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: nodes.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          return ContentItemView(nodes[i]);
        }
    );
  }
}

class ContentItemView extends StatelessWidget {
  final NaviNode naviNode;

  ContentItemView(this.naviNode);

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
                naviNode.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0,),
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: naviNode.articles.map((childNode) {
                  return GestureDetector(
                    child: new ClipRRect(
                      child: Container(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          childNode.title,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      borderRadius: new BorderRadius.circular(3.0),
                    ),
                    onTap: () {

                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}