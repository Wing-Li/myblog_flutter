import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lylblog/model/article_model.dart';
import 'package:lylblog/page/base_state.dart';
import 'package:lylblog/res/markdown_style.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';
import 'package:lylblog/utils/my_date_utils.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:lylblog/view/bottom_about_me_widget.dart';

import '../body_layout_widget.dart';

class ArticleDetailsPage extends StatefulWidget {
  final ArticleModel? model;

  const ArticleDetailsPage({Key? key, this.model}) : super(key: key);

  @override
  _ArticleDetailsPageState createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends BaseState<ArticleDetailsPage> {
  late ArticleModel model;

  @override
  void initState() {
    super.initState();

    if (widget.model != null) {
      model = widget.model!;
    }
  }

  @override
  Widget build(BuildContext context) {
    updatePageSize();

    return BodyLayoutWidget(
      backgroundImageUrl: model.backgroundUrl,
      body: _body(),
    );
  }

  _body() {
    MyMarkdownStyleSheet styleSheet = new MyMarkdownStyleSheet(style: MyMarkdownStyleSheet.DARK_WHITE);

    return Container(
      child: ListView(
        children: [
          _headerLayout(),
          Container(
            color: styleSheet.getBackgroundColor(context),
            child: FractionallySizedBox(
              widthFactor: isWideScreen ? 0.70 : 0.90,
              child: Markdown(
                shrinkWrap: true,
                selectable: true,
                data: model.bodyContent ?? "",
                styleSheet: styleSheet.getStyleSheet(context),
                onTapLink: (String text, String? href, String title) {
                  if (!MyUtils.isEmpty(href)) MyUtils.openUrl(href!);
                },
              ),
            ),
          ),
          BottomAboutMeWidget(isWideScreen: isWideScreen),
        ],
      ),
    );
  }

  _headerLayout() {
    double headerImageHeight = MyUtils.getScreenHeight(context) / 3;
    return Container(
      color: MyTheme.bg_block_tran,
      height: headerImageHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 68),
      child: FractionallySizedBox(
        widthFactor: isWideScreen ? 0.65 : 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.title ?? "",
              style: TextStyles.textWhiteBold(20, letterSpacing: 4, heightSpacingMult: 1.5),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            Text(
              model.message ?? "",
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
}
