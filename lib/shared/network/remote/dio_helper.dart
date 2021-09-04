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
       ),
     );
   // } on Exception catch(e){
   //   print('error while init the dioHelper : $e}');
   // }
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async
  {
    dio.options.headers ={
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization':token?? '',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url, // method
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) async{

      dio.options.headers ={
        'lang': lang,
        'Content-Type': 'application/json',
        'Authorization':token?? '',
      };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    @required String url, // method
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) async{

    dio.options.headers ={
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization':token?? '',
    };

    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

}
