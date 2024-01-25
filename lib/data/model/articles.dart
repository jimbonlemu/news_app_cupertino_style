class ArticlismsResult {
  ArticlismsResult({
    required this.status,
    required this.totalResults,
    required this.articlisms,
  });

  final String status;
  final int totalResults;
  final List<Articlism> articlisms;

  factory ArticlismsResult.fromJson(Map<String, dynamic> json) =>
      ArticlismsResult(
        status: json["status"],
        totalResults: json["totalResults"],
        articlisms: List<Articlism>.from((json["articles"] as List)
            .map((x) => Articlism.fromJson(x))
            .where((article) =>
                article.author != null &&
                article.urlToImage != null &&
                article.publishedAt != null &&
                article.content != null)),
      );

  Map<String, dynamic> toJson() => {
    "status" : status,
    "totalResults" : totalResults,
    "articles" : List<dynamic>.from(articlisms.map((e) => e.toJson())),
  };
}

class Articlism {
  Articlism({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory Articlism.fromJson(Map<String, dynamic> json) => Articlism(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

      Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}
