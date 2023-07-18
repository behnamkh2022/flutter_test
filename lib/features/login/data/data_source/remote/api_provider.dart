import 'package:dio/dio.dart';
import 'package:samim/core/utils/constants/endpoints.dart';

class ApiProvider {
  final Dio _dio = Dio();

  /// all country api call
  Future<dynamic> getCountries() async {
    var response = await _dio.get(
        '${Endpoints.baseUrl}/esmaeil-ahmadipour/restcountries/main/json/countriesV2.json');
    return response;
  }
}
