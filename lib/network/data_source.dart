import 'package:dio/dio.dart';
import 'package:simpsons_demo/data/simpson_character/api/base_model.dart';

abstract class DataSource<T extends BaseModel> {
  final Dio dio;

  DataSource({required this.dio});

  String get baseApiUrl;

  /*
    We can test this method by mocking the response from the API
    We create a mock Dio object to handle the async call using mocktail
    So we will be able to bypass the actual API call and return a mock response
    If we want to test exceptions, we can throw an exception in the mock response
  */

  Future<List<T>> fetchData();
}
