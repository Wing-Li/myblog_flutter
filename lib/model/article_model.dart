class ArticleModel {
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? bodyContent;
  String? message;

  ArticleModel({this.className, this.objectId, this.createdAt, this.updatedAt, this.title, this.bodyContent, this.message});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    title = json['title'];
    bodyContent = json['bodyContent'];
    message = json['message'];
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
    return data;
  }
}
