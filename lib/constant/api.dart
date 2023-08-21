import 'package:dio/dio.dart';

class API {
  final Dio dio;
  static final API _api = API._internal(Dio(
    BaseOptions(baseUrl: 'https://www.timeapi.io/'),
  ));

  factory API() => _api;

  API._internal(this.dio);
}
