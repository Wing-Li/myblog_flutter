import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lylblog/model/article_model.dart';
import 'package:lylblog/page/base_state.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:lylblog/view/bottom_about_me_widget.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../home/body_layout_widget.dart';

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
    return Container(
      child: ListView(
        children: [
          _headerLayout(),
          Container(
            color: MyTheme.white,
            padding: EdgeInsets.symmetric(vertical: 82),
            child: FractionallySizedBox(
              widthFactor: isWideScreen ? 0.70 : 0.90,
              child: _buildMarkdown(),
            ),
          ),
          SizedBox(height: 84),
          BottomAboutMeWidget(isWideScreen: isWideScreen),
        ],
      ),
    );
  }

  bool isDarkNow = false;

  _buildMarkdown() {
    return ListView(
      shrinkWrap: true,
      children: MarkdownGenerator(
        data: model.bodyContent,
        styleConfig: StyleConfig(
            imgBuilder: (String url, attributes) {
              return Image.network(url);
            },
            pConfig: PConfig(
              linkGesture: (linkChild, url) {
                return GestureDetector(
                  child: linkChild,
                  onTap: () => MyUtils.openUrl(url),
                );
              },
              selectable: false,
            ),
            preConfig: PreConfig(
              preWrapper: (child, text) => buildCodeBlock(child, text),
            ),
            tableConfig: TableConfig(
              defaultColumnWidth: FixedColumnWidth(50),
              headChildWrapper: (child) => Container(
                margin: EdgeInsets.all(10.0),
                child: child,
                alignment: Alignment.center,
              ),
              bodyChildWrapper: (child) => Container(
                margin: EdgeInsets.all(10.0),
                child: child,
                alignment: Alignment.center,
              ),
            ),
            markdownTheme: isDarkNow ? MarkdownTheme.darkTheme : MarkdownTheme.lightTheme),
      ).widgets,
    );
  }

  Widget buildCodeBlock(Widget child, String text) {
    return Stack(
      children: <Widget>[
        child,
        Container(
          margin: EdgeInsets.only(top: 5, right: 5),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              Widget toastWidget = Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff006EDF), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(
                        4,
                      )),
                      color: Color(0xff007FFF)),
                  width: 150,
                  height: 40,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        '复制成功',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
              ToastWidget().showToast(context, toastWidget, 500);
            },
            icon: Icon(
              Icons.content_copy,
              size: 10,
            ),
          ),
        )
      ],
    );
  }

  // _body() {
  //   MyMarkdownStyleSheet styleSheet = new MyMarkdownStyleSheet(style: MyMarkdownStyleSheet.DARK_WHITE);
  //
  //   return Container(
  //     child: ListView(
  //       children: [
  //         _headerLayout(),
  //         Container(
  //           color: styleSheet.getBackgroundColor(context),
  //           padding: EdgeInsets.symmetric(vertical: 82),
  //           child: FractionallySizedBox(
  //             widthFactor: isWideScreen ? 0.70 : 0.90,
  //             child: Markdown(
  //               shrinkWrap: true,
  //               selectable: true,
  //               data: model.bodyContent ?? "",
  //               styleSheet: styleSheet.getStyleSheet(context),
  //               onTapLink: (String text, String? href, String title) {
  //                 if (!MyUtils.isEmpty(href)) MyUtils.openUrl(href!);
  //               },
  //             ),
  //           ),
  //         ),
  //         BottomAboutMeWidget(isWideScreen: isWideScreen),
  //       ],
  //     ),
  //   );
  // }

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

class ToastWidget {
  bool isShowing = false;

  void showToast(BuildContext context, Widget widget, int milliseconds) {
    if (!isShowing) {
      isShowing = true;
      FullScreenDialog().showDialog(context, widget);
      Future.delayed(Duration(milliseconds: milliseconds), () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          isShowing = false;
        } else {
          isShowing = false;
        }
      });
    }
  }
}

class FullScreenDialog {
  void showDialog(BuildContext context, Widget child) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (ctx, anm1, anm2) {
          return child;
        }));
  }
}
