import 'dart:convert';

import 'package:leancloud_storage/leancloud.dart';
import 'package:lylblog/config/config.dart';
import 'package:lylblog/model/article_model.dart';
import 'package:lylblog/model/blog_info_data.dart';
import 'package:lylblog/model/topic_model.dart';
import 'package:lylblog/utils/my_utils.dart';

MyDataApi myDataApi = new MyDataApi();

class MyDataApi {
  Future initConfig() async {
    LCQuery<LCObject> query = LCQuery(Config.DB_TABLE_CONFIG);
    List<LCObject> list = await query.find();
    list.forEach((it) {
      String key = it["key"];
      String value = it["value"];

      switch (key) {
        case Config.SP_CONFIG_BLOG_NAME:
          BlogInfoData.saveBlogName(value);
          break;
        case Config.SP_CONFIG_BLOG_INTRODUCTION:
          BlogInfoData.saveBlogIntroduction(value);
          break;
      }
    });
  }

  Future<List<TopicModel>> fetchTopicList() async {
    LCQuery<LCObject> query = LCQuery(Config.DB_TABLE_TOPIC_LIST);
    query.orderByAscending("sort");
    List<LCObject> list = await query.find();

    if (list == null || list.length == 0) return [];

    List<TopicModel> modelList = list.map((it) => TopicModel.fromJson(json.decode(it.toString()))).toList();
    return modelList;
  }

  Future<List<ArticleModel>> fetchArticleList({int limit = 30, int page = 0}) async {
    LCQuery<LCObject> query = LCQuery(Config.DB_TABLE_ARTICLE_LIST);
    query.orderByDescending("updatedAt");
    // query.skip(page * limit);
    // query.limit(limit);
    List<LCObject> list = await query.find();

    if (list == null || list.length == 0) return [];

    List<ArticleModel> modelList = list.map((it) => ArticleModel.fromJson(json.decode(it.toString()))).toList();
    return modelList;
  }
}
