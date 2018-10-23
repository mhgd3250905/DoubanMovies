import 'package:dio/dio.dart';

class HttpUtils {
  static String URL_GET_MOVIE_LIST = 'http://api.douban.com/v2/movie/top250';
  static String URL_GET_MOVIE_DETAIL = 'http://api.douban.com/v2/movie/subject/';
  static String URL_GET_MOVIE_DETAIL_2 = '?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&client=something&udid=dddddddddddddddddddddd';

  static get(String url, {Map map}) async {
    Dio dio = new Dio();
    Response response = await dio.get(url);
    return response.data;
  }
}