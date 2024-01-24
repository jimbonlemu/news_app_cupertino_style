import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/ui/card_article.dart';
import 'package:dicoding_news_app/ui/detail_page.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleListPage extends StatefulWidget {
  static const routeName = '/article_list';

  const ArticleListPage({Key? key}) : super(key: key);

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticlismsResult> _article;

  @override
  void initState() {
    _article = ApiService().topHeadLines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            child: Text('Refresh Data'),
            onPressed: () {
              setState(() {});
            },
          ),
          FutureBuilder(
            future: _article,
            builder: (context, AsyncSnapshot<ArticlismsResult> snapshot) {
              var state = snapshot.connectionState;

              if (state != ConnectionState.done) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ));
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.articlisms.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data?.articlisms[index];
                      return CardArticle(
                        articlism: article!,
                        onPressed: () => Navigator.pushNamed(
                          context,
                          ArticleDetailPage.routeName,
                          arguments: article,
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Material(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                } else {
                  return const Material(child: Text(''));
                }
              }
            },
          )
        ],
      ),
    );
  }

  // Widget _buildArticleList(BuildContext context) {
  //   return FutureBuilder<ArticlismsResult>(
  //     future: _article,
  //     builder: (context, AsyncSnapshot<ArticlismsResult> snapshot) {
  //       var state = snapshot.connectionState;
  //       if (state != ConnectionState.done) {
  //         return const Center(
  //             child: CircularProgressIndicator(
  //           color: Colors.blueGrey,
  //         ));
  //       } else {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: snapshot.data?.articlisms.length,
  //             itemBuilder: (context, index) {
  //               var article = snapshot.data?.articlisms[index];
  //               return CardArticle(articlism: article!);
  //             },
  //           );
  //         } else if (snapshot.hasError) {
  //           return Center(
  //             child: Material(
  //               child: Text(snapshot.error.toString()),
  //             ),
  //           );
  //         } else {
  //           return const Material(child: Text(''));
  //         }
  //       }
  //     },
  //   );
  // }

  // Widget _buildArticleItem(BuildContext context, Article article) {
  //   return Material(
  //     child: ListTile(
  //       contentPadding:
  //           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //       leading: Hero(
  //         tag: article.urlToImage,
  //         child: Image.network(
  //           article.urlToImage,
  //           width: 100,
  //         ),
  //       ),
  //       title: Text(
  //         article.title,
  //       ),
  //       subtitle: Text(article.author),
  //       onTap: () {
  //         Navigator.pushNamed(context, ArticleDetailPage.routeName,
  //             arguments: article);
  //       },
  //     ),
  //   );
  // }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }
}
