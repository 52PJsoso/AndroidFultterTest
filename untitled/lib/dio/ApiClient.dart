import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:untitled/Person.dart';
import 'package:untitled/dio/RequestCallBack.dart';

import 'ApiService.dart';
import 'bean/ApiResponse.dart';
// typedef RequestCallBack<T> = void Function(T value);

class ApiClient {
  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  late Dio _dio;

  ApiClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiService.baseURL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        "Content-Type": "application/json",
      },
    );

    _dio = Dio(options);
    _dio.httpClientAdapter = IOHttpClientAdapter()
      ..onHttpClientCreate = (client) {
        //设置代理 用于Charles抓包
        client.findProxy = (uri) {
          // Forward all request to proxy "localhost:8888".
          return 'PROXY 192.168.85.134:8888';
        };
        // You can also create a new HttpClient for Dio instead of returning,
        // but a client must being returned here.
        return client;
      };
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // 设置请求头
      // options.headers["Authorization"] = "Bearer $token";
      print("请求uri：${options.uri}");
      print("请求地址：${options.path}");
      print("options.queryParameters请求参数：${options.queryParameters}");
      print("data请求参数：${options.data.toString()}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      // 处理响应数据
      print("响应内容：${response.data}");
      return handler.next(response);
    }, onError: (DioError error, handler) {
      // 处理请求错误
      print("错误信息：${error.message}");
      print("错误码：${error.response?.statusCode}");
      return handler.next(error);
    }));
  }


  Future<Person> getUserInfo(Map<String, dynamic> map) async {
    Response response =
        await _dio.get(ApiService.userInfo, queryParameters: map);
    return Person.fromJson(response.data);
  }



  Future<ApiResponse<String>> login(RequestCallBack requestCallBack,{Map<String, dynamic>? map}) async {
    Response response = await _dio.post(ApiService.login, queryParameters: map);
    if (response.statusCode == 200) {
      requestCallBack.onSuccess(response.data);
    }else{
      requestCallBack.onError(response.data);
    }
    return ApiResponse<String>.fromJson(response.data);
  }
}
