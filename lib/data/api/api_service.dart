import 'dart:convert';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '01f359cbbd834f2096607f7e0910cfd7';
  static const String _category = 'business';
  static const String _country = 'us';

  Future<ArticlismsResult> topHeadLines() async {
    final response = await http.get(Uri.parse(
        '${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      return ArticlismsResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch the data');
    }
  }
}
