class NewsModel {
  String? author;
  String? title;
  String? excerpt;
  String? link;
  String? media;
  String? published_date;
  String? content;
  String? topic;
  String? summary;
  String? likerid;

  NewsModel(
      {this.author, this.title, this.excerpt, this.link, this.media, this.published_date, this.content,
      this.topic,this.summary,this.likerid});

  // receiving data from server
  factory NewsModel.fromMap(map) {
    return NewsModel(
      author: map['author'],
      title: map['title'],
      excerpt: map['excerpt'],
      link: map['link'],
      media: map['media'],
      published_date: map['published_date'],
      content:map['content'],
      topic:map['topic'],
      summary:map['summary'],
      likerid: map['likerid']

    );
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        author: json['author'],
        title: json['title'],
        excerpt: json['description'],
        link: json['link'],
        media: json['media'],
        published_date: json['published_date'],
        content: json['content'],
        topic:json['topic'],
        summary:json['summary'],
        likerid: json['likerid']
      );


  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'title': title,
      'excerpt': excerpt,
      'link': link,
      'media': media,
      'published_date': published_date,
      'content': content,
      'topic':topic,
      'summary':summary,
      'likerid':likerid
    };
  }

  Map<String, dynamic> toJson() => {
        "author": author,
        'title': title,
      'description': excerpt,
      'link': link,
      'media': media,
      'published_date': published_date,
      'content': content,
    'topic': topic,
    'summary':summary,
    'likerid':likerid
      };
}
