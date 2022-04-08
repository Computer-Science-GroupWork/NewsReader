class NewsModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? topic;
  String? summary;

  NewsModel(
      {this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content,
      this.topic,this.summary});

  // receiving data from server
  factory NewsModel.fromMap(map) {
    return NewsModel(
      author: map['author'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content:map['content'],
      topic:map['topic'],
      summary:map['summary']
    );
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content'],
        topic:json['topic'],
        summary:json['summary']
      );


  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'topic':topic,
      'summary':summary
    };
  }

  Map<String, dynamic> toJson() => {
        "author": author,
        'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    'topic': topic,
    'summary':summary
      };
}
