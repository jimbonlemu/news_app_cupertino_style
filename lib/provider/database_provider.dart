import 'package:dicoding_news_app/data/db/database_helper.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:flutter/foundation.dart';

import '../utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper});

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Articlism> _bookmarks = [];
  List<Articlism> get bookmark => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getBookmarks();

    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addBookmark(Articlism articlism) async {
    try {
      await databaseHelper.insertBookmark(articlism);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String url) async {
    final bookmarkedArticle = await databaseHelper.getBookmarkByUrl(url);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHelper.removeBookmark(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error ---> $e';
      notifyListeners();
    }
  }
}
