import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:flutter/material.dart';
import 'dart:async';

enum ResultState { loading, noData, hasData, error }

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {
    _fetchAllArticles();
  }

  late ArticlismsResult _articleResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ArticlismsResult get result => _articleResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllArticles() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await apiService.topHeadLines();

      if (article.articlisms.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _articleResult = article;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
