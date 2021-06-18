import 'dart:convert';
import 'package:sms_gateway/http/url.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class HttpService {
  late Dio _http;
  final String? baseUrl;

  final headers = {"Content-Type": "application/json"};

  HttpService({this.baseUrl}) {
    _http = Dio(BaseOptions(
      baseUrl: baseUrl ?? urlBase,
      headers: headers,
    ));
    initializeInterceptors();
  }

  initializeInterceptors() {
    _http.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) {
      logger.e(e.message, 'Api Error');
      return handler.next(e);
    }));
  }

  Future<Response> post({String? url, Map? body}) async {
    print(body);
    Response response;
    try {
      response = await _http.post(
        url ?? '',
        data: jsonEncode(body ?? {}),
      );
    } on DioError catch (e) {
      logger.e(e.message, 'Api Error');
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> put({String? url, Map? body}) async {
    Response response;
    try {
      response = await _http.put(
        url ?? '',
        data: jsonEncode(body ?? {}),
      );
    } on DioError catch (e) {
      logger.e(e.message, 'Api Error');
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> get({String? url}) async {
    Response response;
    try {
      response = await _http.get(url ?? '');
    } on DioError catch (e) {
      logger.e(e.message, 'Api Error');
      throw Exception(e.message);
    }
    return response;
  }
}
