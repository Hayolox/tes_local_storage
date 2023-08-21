import '../../constant/api.dart';

class ApiProvider {
  final API _api = API();
  Future<dynamic> getTime() async {
    final response =
        await _api.dio.get('api/Time/current/zone?timeZone=Asia/Jakarta');
    return response.data;
  }
}
