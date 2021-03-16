import 'package:lylblog/model/topic_model.dart';

class ArticleModel {
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? bodyContent;
  String? message;
  String? backgroundUrl;
  TopicModel? topic;
  bool isHome = false;

  ArticleModel({
    this.className,
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.bodyContent,
    this.message,
    this.backgroundUrl,
    this.isHome = false,
    this.topic,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    title = json['title'];
    bodyContent = json['bodyContent'];
    message = json['message'];
    backgroundUrl = json['backgroundUrl'];
    isHome = json['isHome'];
    topic = json['topic'] != null ? TopicModel.fromJson(json['topic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['className'] = this.className;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['title'] = this.title;
    data['bodyContent'] = this.bodyContent;
    data['message'] = this.message;
    data['backgroundUrl'] = this.backgroundUrl;
    data['isHome'] = this.isHome;
    if (this.topic != null) data['topic'] = this.topic?.toJson();
    return data;
  }
}
