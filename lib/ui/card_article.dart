import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/ui/detail_page.dart';
import 'package:flutter/material.dart';

class CardArticle extends StatelessWidget {
  final Articlism articlism;
  final Function onPressed;

  const CardArticle({Key? key, required this.articlism, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: articlism.urlToImage!,
          child: Image.network(
            articlism.urlToImage!,
            width: 100,
          ),
        ),
        title: Text(articlism.title),
        subtitle: Text(articlism.author ?? ""),
        onTap: () {
          Navigator.pushNamed(context, ArticleDetailPage.routeName,
              arguments: articlism);
        },
      ),
    );
  }
}
