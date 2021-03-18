import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lylblog/model/article_model.dart';
import 'package:lylblog/model/topic_model.dart';
import 'package:lylblog/net/my_data_api.dart';
import 'package:lylblog/page/article/article_details_page.dart';
import 'package:lylblog/page/article/article_list_page.dart';
import 'package:lylblog/page/base_state.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';
import 'package:lylblog/utils/my_date_utils.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:lylblog/view/bottom_about_me_widget.dart';
import 'package:lylblog/view/dotted_line_widget.dart';

import '../home/body_layout_widget.dart';

class TopicListPage extends StatefulWidget {
  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends BaseState<TopicListPage> {
  String title = "分类";
  String message = "文章的分类";
  String backgroundImageUrl = "http://arkadianriver.github.io/spectral/images/banner.jpg";

  List<TopicModel> list = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _fetchData);
  }

  _fetchData() async {
    list = await myDataApi.fetchTopicList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    updatePageSize();

    return BodyLayoutWidget(
      backgroundImageUrl: backgroundImageUrl,
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: ListView(
        children: [
          _headerLayout(),
          Container(
            color: MyTheme.white,
            padding: EdgeInsets.only(top: 62, bottom: 182),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                var model = list[index];
                return GestureDetector(
                  child: _topicItem(model),
                  onTap: () {
                    MyUtils.startPage(context, ArticleListPage());
                  },
                );
              },
            ),
          ),
          BottomAboutMeWidget(isWideScreen: isWideScreen),
        ],
      ),
    );
  }

  _headerLayout() {
    double headerImageHeight = MyUtils.getScreenHeight(context) / 2;
    return Container(
      color: MyTheme.bg_block_tran,
      height: headerImageHeight,
      alignment: Alignment.center,
      child: FractionallySizedBox(
        widthFactor: isWideScreen ? 0.65 : 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyles.textWhiteBold(20, letterSpacing: 4, heightSpacingMult: 1.5),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyles.textWhite(16, heightSpacingMult: 1.5),
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  _topicItem(TopicModel model) {
    return Container(
      color: MyTheme.white,
      child: FractionallySizedBox(
        widthFactor: isWideScreen ? 0.75 : 0.90,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 4),
                Text(model.name ?? "", style: TextStyles.textBold(18, letterSpacing: 4, heightSpacingMult: 1.5, fontFamily: "黑体")),
                SizedBox(width: 16),
                Expanded(child: Text(model.message ?? "", style: TextStyles.text(16, heightSpacingMult: 1.5), overflow: TextOverflow.ellipsis)),
              ],
            ),
            SizedBox(height: 20),
            DottedLineWidget(
              height: 2,
              color: MyTheme.text_block_white_deep,
            ),
          ],
        ),
      ),
    );
  }
}
