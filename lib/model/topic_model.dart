class TopicModel {
  String? className;
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? message;
  String? sort;
  String? type;

  TopicModel({
    this.className,
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.message,
    this.sort,
    this.type,
  });

  TopicModel.fromJson(Map<String, dynamic> json) {
    className = json['className'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    message = json['message'];
    sort = json['sort'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['className'] = this.className;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['name'] = this.name;
    data['message'] = this.message;
    data['sort'] = this.sort;
    data['type'] = this.type;
    return data;
  }
}
