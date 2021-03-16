import 'package:lylblog/config/config.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:lylblog/utils/shared_preferences.dart';

class BlogInfoData {
  static void saveBlogName(String value) {
    spUtil.putString(Config.SP_CONFIG_BLOG_NAME, value);
  }

  static String getBlogName() {
    String name = spUtil.getString(Config.SP_CONFIG_BLOG_NAME);

    return MyUtils.isEmpty(name) ? "Wing Li" : name;
  }

  static void saveBlogIntroduction(String value) {
    spUtil.putString(Config.SP_CONFIG_BLOG_INTRODUCTION, value);
  }

  static String getBlogIntroduction() {
    return spUtil.getString(Config.SP_CONFIG_BLOG_INTRODUCTION);
  }


}
