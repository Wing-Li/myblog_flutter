import 'package:flutter/material.dart';
import 'package:lylblog/page/base_state.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:lylblog/view/my_app_bar.dart';
import 'package:lylblog/view/my_network_image_widget.dart';

import '../body_layout_widget.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends BaseState<ArticleListPage> {
  @override
  Widget build(BuildContext context) {
    return BodyLayoutWidget(
      backgroundImageUrl: "http://arkadianriver.github.io/spectral/images/banner.jpg",
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: ListView(
        children: [
          _headerLayout(),
        ],
      ),
    );
  }

  _headerLayout() {
    double headerImageHeight = MyUtils.getScreenHeight(context) * 2 / 5;
    return Container(
      color: MyTheme.bg_block_tran,
      height: headerImageHeight,
      alignment: Alignment.center,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "ELEMENTS",
              style: TextStyles.textWhiteBold(20, letterSpacing: 4, heightSpacingMult: 1.5),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            Text(
              "ALIQUAM UT EX UT INTERDUM DONEC AMET IMPERDIET ELEIFEND",
              style: TextStyles.textWhite(16, heightSpacingMult: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
