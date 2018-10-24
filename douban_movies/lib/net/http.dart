import 'package:dio/dio.dart';

class HttpUtils {
  static String URL_GET_MOVIE_LIST = 'https://api.douban.com/v2/movie/in_theaters';
  static String URL_GET_MOVIE_DETAIL = 'http://api.douban.com/v2/movie/subject/';
  static String URL_API_KEY='0b2bdeda43b5688921839c8ecb20399b';
  static String URL_UDID='dddddddddddddddddddddd';

  static get(String url, {Map map}) async {
    Dio dio = new Dio();
    Response response = await dio.get(url,data: map);
    return response.data;
  }
}