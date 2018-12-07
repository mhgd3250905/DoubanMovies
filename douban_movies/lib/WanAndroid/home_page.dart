import 'package:douban_movies/WanAndroid/article_list_content.dart';
import 'package:douban_movies/WanAndroid/knowledge_tree_page.dart';
import 'package:douban_movies/WanAndroid/project_page.dart';
import 'package:douban_movies/WanAndroid/search_page.dart';
import 'article_page.dart';
import 'package:flutter/material.dart';

class WanAndroidMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '玩安卓',
      home: new WanAndroidHomePage(),
    );
  }
}

class WanAndroidHomePage extends StatefulWidget {
  @override
  _WanAndroidHomePageState createState() => _WanAndroidHomePageState();
}

class _WanAndroidHomePageState extends State<WanAndroidHomePage> {
  final _pages = [
    ArticleListPage(url:URL_HOME_ARTICLE_LIST,type: ArticleType.NORMAL_ARTICLE,),
    KnowledgeTreePage(),
    ProjectTreePage(),
  ];
  final _controller = PageController(initialPage: 0);
  int _selectedIndex = 0;

  void onItemTap(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('玩安卓'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new SearchPage()),
              );
            },
          ),
        ],
      ),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: _pages,
        onPageChanged: (index) {
          if (_selectedIndex != index) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('文章'),
              backgroundColor: Colors.blue),
          new BottomNavigationBarItem(
            icon: Icon(Icons.perm_device_information),
            title: Text('知识树'),
            backgroundColor: Colors.green,
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.attach_file),
            title: Text('项目'),
            backgroundColor: Colors.yellow,
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: onItemTap,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
} /*

new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('文章'),
              backgroundColor: Colors.blue),
          new BottomNavigationBarItem(
              icon: Icon(Icons.perm_device_information),
              title: Text('知识树'),
              backgroundColor: Colors.green),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: onItemTap,
        type: BottomNavigationBarType.shifting,
      )
*/
