import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:dicoding_news_app/widgets/card_article.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatelessWidget {
  static const routeName = '/article_list';

  ArticleListPage({Key? key}) : super(key: key);

  // late Future<ArticlismsResult> _article;

  // @override


  Widget _buildTheList() {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blueGrey,
          ));
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articlisms.length,
            itemBuilder: (context, index) {
              var article = state.result.articlisms[index];
              return CardArticle(articlism: article);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          print(state.message);
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  // Widget _buildList(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         ElevatedButton(
  //           child: Text('Refresh Data'),
  //           onPressed: () {},
  //         ),
  //         FutureBuilder(
  //           future: _article,
  //           builder: (context, AsyncSnapshot<ArticlismsResult> snapshot) {
  //             var state = snapshot.connectionState;

  //             if (state != ConnectionState.done) {
  //               return const Center(
  //                   child: CircularProgressIndicator(
  //                 color: Colors.blueGrey,
  //               ));
  //             } else {
  //               if (snapshot.hasData) {
  //                 return ListView.builder(
  //                   shrinkWrap: true,
  //                   itemCount: snapshot.data?.articlisms.length,
  //                   itemBuilder: (context, index) {
  //                     var article = snapshot.data?.articlisms[index];
  //                     return CardArticle(
  //                       articlism: article!,

  //                     );
  //                   },
  //                 );
  //               } else if (snapshot.hasError) {
  //                 return Center(
  //                   child: Material(
  //                     child: Text(snapshot.error.toString()),
  //                   ),
  //                 );
  //               } else {
  //                 return const Material(child: Text(''));
  //               }
  //             }
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildArticleList(BuildContext context) {
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildTheList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildTheList(),
    );
  }

    @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
