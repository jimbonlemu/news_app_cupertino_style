import 'package:dicoding_news_app/common/navigations.dart';
import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/provider/database_provider.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Articlism articlism;

  const CardArticle({
    Key? key,
    required this.articlism,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, databaseProvider, child) {
        return FutureBuilder<bool>(
          future: databaseProvider.isBookmarked(articlism.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              color: primaryColor,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: articlism.urlToImage!,
                  child: Image.network(
                    articlism.urlToImage!,
                    width: 100,
                  ),
                ),
                trailing: isBookmarked
                    ? IconButton(
                        onPressed: () =>
                            databaseProvider.removeBookmark(articlism.url),
                        color: Theme.of(context).colorScheme.secondary,
                        icon: const Icon(Icons.bookmark))
                    : IconButton(
                        onPressed: () =>
                            databaseProvider.addBookmark(articlism),
                        color: Theme.of(context).colorScheme.secondary,
                        icon: const Icon(Icons.bookmark_border),
                      ),
                title: Text(articlism.title),
                subtitle: Text(articlism.author ?? ""),
                onTap: () => Navigation.intentWithData(
                    ArticleDetailPage.routeName, articlism),
              ),
            );
          },
        );
      },
    );
  }
}
