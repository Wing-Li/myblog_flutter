import 'package:flutter/material.dart';
import 'package:lylblog/model/article_model.dart';
import 'package:lylblog/net/my_data_api.dart';
import 'package:lylblog/page/article/article_details_page.dart';
import 'package:lylblog/page/base_state.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';
import 'package:lylblog/utils/my_date_utils.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:lylblog/view/bottom_about_me_widget.dart';

import '../body_layout_widget.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends BaseState<ArticleListPage> {
  List<ArticleModel> list = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _fetchData);
  }

  _fetchData() async {
    list = await myDataApi.fetchArticleList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    updatePageSize();

    return BodyLayoutWidget(
      backgroundImageUrl: "http://arkadianriver.github.io/spectral/images/banner.jpg",
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: ListView.builder(
        itemCount: list.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _headerLayout();
          } else if (index == list.length + 1) {
            return BottomAboutMeWidget(isWideScreen: isWideScreen);
          } else {
            var model = list[index - 1];
            return GestureDetector(
              child: _articleItem(model),
              onTap: () {
                MyUtils.startPage(context, ArticleDetailsPage());
              },
            );
          }
        },
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
              "ELEMENTS",
              style: TextStyles.textWhiteBold(20, letterSpacing: 4, heightSpacingMult: 1.5),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            Text(
              "ALIQUAM UT EX UT INTERDUM DONEC AMET IMPERDIET ELEIFEND",
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

  _articleItem(ArticleModel model) {
    return Container(
      color: MyTheme.white,
      child: FractionallySizedBox(
        widthFactor: isWideScreen ? 0.75 : 0.90,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 48),
            Text(
              model.title ?? "",
              style: TextStyles.textBold(18, letterSpacing: 4, heightSpacingMult: 1.5),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            MyUtils.isEmpty(model.createdAt) ? Container() : Text(model.createdAt?.substring(0, 19) ?? "", style: TextStyles.textGrayDeep(14)),
            SizedBox(height: 24),
            Text(
              model.message ?? "",
              style: TextStyles.text(16, heightSpacingMult: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 48),
            Container(width: double.infinity, height: 2, color: MyTheme.text_block_white_deep),
          ],
        ),
      ),
    );
  }
}
