import 'dart:convert';

import 'package:leancloud_storage/leancloud.dart';
import 'package:lylblog/config/config.dart';
import 'package:lylblog/model/article_model.dart';
import 'package:lylblog/utils/my_utils.dart';

MyDataApi myDataApi = new MyDataApi();

class MyDataApi {
  Future<List<ArticleModel>> fetchArticleList({int limit = 30, int page = 0}) async {
    LCQuery<LCObject> query = LCQuery(Config.DB_TABLE_ARTICLE_LIST);
    query.orderByDescending("updatedAt");
    query.skip(page * limit);
    query.limit(limit);
    List<LCObject> list = await query.find();

    if (list == null || list.length == 0) return [];

    List<ArticleModel> modelList = list.map((it) => ArticleModel.fromJson(json.decode(it.toString()))).toList();
    return modelList;
  }
}
