import 'package:dicoding_news_app/common/navigations.dart';
import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:flutter/material.dart';

class CardArticle extends StatelessWidget {
  final Articlism articlism;

  const CardArticle({
    Key? key,
    required this.articlism,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: Text(articlism.title),
        subtitle: Text(articlism.author ?? ""),
        onTap: () =>
            Navigation.intentWithData(ArticleDetailPage.routeName, articlism),
      ),
    );
  }
}
