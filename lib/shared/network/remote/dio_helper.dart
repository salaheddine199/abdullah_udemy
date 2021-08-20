import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  /// news app:
  // static init() {
  //   dio = Dio(
  //     BaseOptions(
  //       baseUrl: 'https://newsapi.org/',
  //       receiveDataWhenStatusError: true,
  //     ),
  //   );
  // }
  //
  // static Future<Response> getData({
  //   @required String url,
  //   @required Map<String, dynamic> query,
  // }) async
  // {
  //   return await dio.get(
  //     url,
  //     queryParameters: query,
  //   );
  // }

  /// shop app:
  static init() {
   // try{
     dio = Dio(
       BaseOptions(
         baseUrl: 'https://student.valuxapps.com/api/',
         receiveDataWhenStatusError: true,
         headers: {
           'Content-Type': 'application/json',
           'lang':'ar',
         },
       ),
     );
   // } on Exception catch(e){
   //   print('error while init the dioHelper : $e}');
   // }
  }

  static Future<Response> getData({
    @required String url,
    @required Map<String, dynamic> query,
    String lang = 'ar',
    String token,
  }) async
  {
    dio.options.headers ={
      'lang': lang,
      'Authorization':token,
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang = 'ar',
    String token,
  }) async{

      dio.options.headers ={
        'lang': lang,
        'Authorization':token,
      };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

}
