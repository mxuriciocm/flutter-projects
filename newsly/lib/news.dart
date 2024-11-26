class News {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  News(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  News.fromJson(Map<String, dynamic> json)
      : this(
            author: json['author'] ?? '',
            title: json['title'] ?? '',
            description: json['description'] ?? '',
            publishedAt: json['publishedAt'] ?? '',
            content: json['content'] ?? '',
            url: json['url'] ?? '',
            urlToImage: json['urlToImage'] ?? '');
}
