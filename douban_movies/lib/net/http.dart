import 'package:dio/dio.dart';

class HttpUtils {
  static String URL_GET_MOVIE_LIST = 'http://api.douban.com/v2/movie/top250?start=25&count=25';
  static String URL_GET_MOVIE_DETAIL = 'http://api.douban.com/v2/movie/subject/';

  static get(String url, {Map map}) async {
    Dio dio = new Dio();
    Response response = await dio.get(url);
    return response.data;
  }
}