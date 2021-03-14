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
  @override
  _ArticleDetailsPageState createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends BaseState<ArticleDetailsPage> {
  List<ArticleModel> list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updatePageSize();

    return BodyLayoutWidget(
      backgroundImageUrl: "http://arkadianriver.github.io/spectral/images/banner.jpg",
      body: _body(),
    );
  }

  String markdownSource = """
# h1 标题
## h2 标题
### h3 标题
#### h4 标题
##### h5 标题
###### h6 标题


## 水平线

___

---

***


## 文本样式

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## 列表

无序

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

有序

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa


1. You can use sequential numbers...
1. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar


## 代码

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code


Block code "fences"

```
Sample text here...
```

Syntax highlighting

``` js
var foo = function (bar) {
  return bar++;
};

console.log(foo(5));
```
""";

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
                data: markdownSource,
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
}
