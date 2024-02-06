import 'package:dicoding_news_app/provider/database_provider.dart';
import 'package:dicoding_news_app/utils/result_state.dart';
import 'package:dicoding_news_app/widgets/card_article.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookMarkPage extends StatelessWidget {
  static const String bookmarksTitle = 'Bookmarks';
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(bookmarksTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(bookmarksTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, dbProvider, child) {
        if (dbProvider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: dbProvider.bookmarks.length,
            itemBuilder: (context, index) {
              return CardArticle(articlism: dbProvider.bookmarks[index]);
            },
          );
        } else {
          return Center(
            child: Material(
              child: Text(dbProvider.message),
            ),
          );
        }
      },
    );
  }
}
