import 'dart:convert';

import 'package:dio/src/dio.dart';
import 'package:simpsons_demo/data/simpson_character/api/related_topic.dart';
import 'package:simpsons_demo/network/constants.dart';
import 'package:simpsons_demo/network/data_source.dart';

class SimpsonsDataSourceImpl implements DataSource {
  @override
  Dio get dio => Dio();

  @override
  String get baseApiUrl => baseUrl;

  @override
  Future<List<RelatedTopic>> fetchData() async {
    try {
      final response =
          await dio.get('$baseApiUrl/?q=simpsons+characters&format=json');

      Map<String, dynamic> parsedData = jsonDecode(response.data);
      List<dynamic> realtedTopicsJson = parsedData['RelatedTopics'];

      List<RelatedTopic> relatedTopics =
          realtedTopicsJson.map((json) => RelatedTopic.fromJson(json)).toList();

      return relatedTopics;
    } catch (e) {
      throw Exception(e);
    }
  }
}
