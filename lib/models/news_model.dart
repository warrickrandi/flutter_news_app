import 'dart:convert';

import 'package:news/models/base/base_model.dart';

const jsonCodec = const JsonCodec();

class NewsModel extends BaseModel {
  String status;
  int totalResults;
  List<Articles> articles;

  NewsModel({this.status, this.totalResults, this.articles});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    List<Articles> articlesList = [];
    if (list != null) {
      articlesList = list.map((i) => Articles.fromJson(i)).toList();
    }

    return NewsModel(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: articlesList);
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'totalResults': totalResults, 'articles': articles};
}

class Articles {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Articles.fromJson(Map<String, dynamic> json) {
    // print(json['source']);
    // print(json['source']['id']);
    
    // var list = json['source'] as List;
    // List<Source> sourceList = [];
    // if (list != null) {
    //   sourceList = list.map((i) => Source.fromJson(i)).toList();
    // }

    return Articles(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() => {
        'source': source,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content,
      };
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  Source.fromJson(Map<String,dynamic> json) :
    id = json['id'],
    name = json['name'];
  

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
