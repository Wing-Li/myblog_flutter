import 'package:flutter/material.dart';
import 'package:lylblog/page/base_state.dart';
import 'package:lylblog/page/home/home_page.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:lylblog/view/my_app_bar.dart';
import 'package:lylblog/view/my_network_image_widget.dart';

import 'article/article_list_page.dart';

class BodyLayoutWidget extends StatefulWidget {
  final bool isShowAppBarBg;
  final Widget? appBar;
  final Widget? body;
  final String? backgroundImageUrl;

  const BodyLayoutWidget({Key? key, this.isShowAppBarBg = true, this.appBar, this.body, this.backgroundImageUrl}) : super(key: key);

  @override
  _BodyLayoutWidgetState createState() => _BodyLayoutWidgetState();
}

class _BodyLayoutWidgetState extends State<BodyLayoutWidget> {
  bool isShowAppBarBg = true;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didUpdateWidget(covariant BodyLayoutWidget oldWidget) {
    isShowAppBarBg = widget.isShowAppBarBg;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    isShowAppBarBg = widget.isShowAppBarBg;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(child: _drawer(context)),
      body: Stack(
        children: [
          MyUtils.isEmpty(widget.backgroundImageUrl)
              ? Container(color: MyTheme.bg_tab, width: double.infinity, height: double.infinity)
              : MyNetworkImage(
                  widget.backgroundImageUrl!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholderWidget: Container(color: MyTheme.bg_tab),
                ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: widget.body,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: widget.appBar == null ? _appBar(context) : widget.appBar,
          ),
        ],
      ),
    );
  }

  _appBar(context) {
    return MyAppBar(
      bgColor: isShowAppBarBg ? MyTheme.bg_tab : MyTheme.transparent,
      leftWidget: isShowAppBarBg ? Text("WING LI", style: TextStyles.title(18, isFontWeightBold: true)) : Container(),
      rightWidget: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          Text("MENU", style: TextStyles.textWhite(16)),
          SizedBox(width: 8),
          Icon(Icons.menu, color: MyTheme.white),
          SizedBox(width: 16),
        ],
      ),
      onRightTap: () {
        scaffoldKey.currentState?.openEndDrawer();
      },
    );
  }

  _drawer(context) {
    return Container(
      color: MyTheme.bg_home_item,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 52,
              alignment: Alignment.centerRight,
              child: Icon(Icons.close, color: MyTheme.white, size: 28),
            ),
            onTap: () => MyUtils.disMissLoadingDialog(context),
          ),
          SizedBox(height: 8),
          InkWell(
            child: _drawerItem(Icons.home, "Home"),
            onTap: () => MyUtils.startPageGradient(context, HomePage()),
          ),
          Divider(height: 0.4, color: MyTheme.line_deep),
          _drawerItem(Icons.library_books_outlined, "Library"),
          Divider(height: 0.4, color: MyTheme.line_deep),
          InkWell(
            child: _drawerItem(Icons.archive, "Archive"),
            onTap: () => MyUtils.startPageGradient(context, ArticleListPage()),
          ),
          Divider(height: 0.4, color: MyTheme.line_deep),
          _drawerItem(Icons.person_rounded, "About Me"),
        ],
      ),
    );
  }

  _drawerItem(IconData icon, String title) {
    return Container(
      height: 54,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          Icon(icon, color: MyTheme.white),
          SizedBox(width: 24),
          Text(title, style: TextStyles.textWhite(16)),
        ],
      ),
    );
  }
}
