import 'package:flutter/material.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:lylblog/view/my_network_image_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShowAppBarBg = false;
  bool isWideScreen = true;
  double pageHeight = 946.0;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      var _tempShowTop = _scrollController.offset >= (isWideScreen ? pageHeight : pageHeight * 0.45);
      if (_tempShowTop != isShowAppBarBg) {
        setState(() {
          isShowAppBarBg = _tempShowTop;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageHeight = MyUtils.getScreenHeight(context);

    return Scaffold(
      endDrawer: Drawer(child: _drawer()),
      body: Stack(
        children: [
          MyNetworkImage(
            "http://arkadianriver.github.io/spectral/images/banner.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            placeholderWidget: Container(color: MyTheme.bg_tab),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: _body(),
          ),
          _appBar(),
        ],
      ),
    );
  }

  _appBar() {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: isShowAppBarBg ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: Container(
            width: double.infinity,
            height: 56,
            color: MyTheme.bg_tab,
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text("WING LI", style: TextStyles.title(18, isFontWeightBold: true)),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Builder(builder: (context) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("MENU", style: TextStyles.textWhite(16)),
                  SizedBox(width: 8),
                  Icon(Icons.menu, color: MyTheme.white),
                  SizedBox(width: 16),
                ],
              ),
              onTap: () => Scaffold.of(context).openEndDrawer(),
            );
          }),
        ),
      ],
    );
  }

  _drawer() {
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
          _drawerItem(Icons.home, "Home"),
          Divider(height: 0.4, color: MyTheme.line_deep),
          _drawerItem(Icons.library_books_outlined, "Library"),
          Divider(height: 0.4, color: MyTheme.line_deep),
          _drawerItem(Icons.archive, "Archive"),
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

  _body() {
    return OrientationBuilder(builder: (context, orientation) {
      isWideScreen = MyUtils.getScreenWidth(context) >= 762;

      return ListView(
        controller: _scrollController,
        children: [
          _welcomeLayout(),
          _userInfoLayout(),
          _articleLayout(
            true,
            "http://arkadianriver.github.io/spectral/images/pic01.jpg",
            "MAGNA PRIMIS LOBORTIS SED ULLAMCORPER",
            "Aliquam ut ex ut augue consectetur interdum. Donec hendrerit imperdiet. Mauris eleifend fringilla nullam aenean mi ligula.",
          ),
          _articleLayout(
            false,
            "http://arkadianriver.github.io/spectral/images/pic02.jpg",
            "MAGNA PRIMIS LOBORTIS SED ULLAMCORPER",
            "Aliquam ut ex ut augue consectetur interdum. Donec hendrerit imperdiet. Mauris eleifend fringilla nullam aenean mi ligula.",
          ),
          _articleLayout(
            true,
            "http://arkadianriver.github.io/spectral/images/pic03.jpg",
            "MAGNA PRIMIS LOBORTIS SED ULLAMCORPER",
            "Aliquam ut ex ut augue consectetur interdum. Donec hendrerit imperdiet. Mauris eleifend fringilla nullam aenean mi ligula.",
          ),
          _linkMeLayout(),
          _aboutLayout(),
        ],
      );
    });
  }

  _welcomeLayout() {
    return Container(
      color: MyTheme.bg_block_tran,
      width: double.infinity,
      height: isWideScreen ? pageHeight : pageHeight * 0.48,
      child: Column(
        children: [
          Spacer(flex: 5),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: isWideScreen ? 278 : 146, height: 2.5, color: MyTheme.white),
              SizedBox(height: isWideScreen ? 18 : 10),
              Text("Wing Li", style: TextStyles.textWhiteBold(isWideScreen ? 28 : 20, letterSpacing: 6)),
              SizedBox(height: isWideScreen ? 18 : 10),
              Container(width: isWideScreen ? 278 : 146, height: 2.5, color: MyTheme.white),
              SizedBox(height: 56),
              Text(
                "ANOTHER FINE RESPONSIVE\nSITE TEMPLATE FREEBIE\nCRAFTED BY HTML5 UP",
                style: TextStyles.textWhite(16, isFontWeightBold: true, letterSpacing: 3, heightSpacingMult: 1.3),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28),
              ButtonTheme(
                minWidth: isWideScreen ? 148 : 288,
                height: 48,
                child: RaisedButton(
                  color: MyTheme.orange,
                  child: Text('ACTIVATE', style: TextStyles.textWhiteBold(14, isFontWeightBold: true)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Spacer(flex: 4),
          isWideScreen
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("LEARN MORE", style: TextStyles.textWhite(14, letterSpacing: 2)),
                    SizedBox(height: 8),
                    Icon(Icons.arrow_downward, color: MyTheme.white, size: 32),
                    SizedBox(height: 56),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  _userInfoLayout() {
    return Container(
      color: MyTheme.bg_home_item,
      height: MyUtils.getScreenHeight(context) * 370 / 900,
      child: FractionallySizedBox(
        widthFactor: isWideScreen ? 0.60 : 0.85,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "ARCU ALIQUET VEL LOBORTIS ATA NISL EGET AUGUE AMET ALIQUET NISL CEP DONEC",
                style: TextStyles.textWhiteBold(isWideScreen ? 18 : 16, letterSpacing: 4, heightSpacingMult: 1.7),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16),
              Divider(height: 1, color: MyTheme.line_deep),
              SizedBox(height: 16),
              Text(
                "Aliquam ut ex ut augue consectetur interdum. Donec amet imperdiet eleifend fringilla tincidunt. Nullam dui leo Aenean mi ligula, rhoncus ullamcorper.",
                style: TextStyles.textWhite(isWideScreen ? 16 : 14, heightSpacingMult: 1.5),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 44),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.link, size: 36),
                  SizedBox(width: 32),
                  Icon(Icons.favorite_border, size: 36),
                  SizedBox(width: 32),
                  Icon(Icons.code, size: 36),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _articleLayout(bool isLeft, String imgUrl, String title, String message) {
    return isWideScreen
        ? Container(
            width: double.infinity,
            height: 335,
            color: isLeft ? MyTheme.bg_tab : MyTheme.main_deep,
            child: Row(
              children: [
                isLeft ? Expanded(flex: 45, child: MyNetworkImage(imgUrl)) : Container(),
                Expanded(
                  flex: 55,
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.80,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyles.textWhiteBold(20, letterSpacing: 4, heightSpacingMult: 1.5),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 16),
                          Text(
                            message,
                            style: TextStyles.textWhite(16, heightSpacingMult: 1.5),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                isLeft ? Container() : Expanded(flex: 45, child: MyNetworkImage(imgUrl)),
              ],
            ),
          )
        : Container(
            color: MyTheme.bg_tab,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 500 / 354,
                  child: MyNetworkImage(imgUrl, width: double.infinity, fit: BoxFit.fitWidth),
                ),
                SizedBox(height: 56),
                FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Text(
                    title,
                    style: TextStyles.textWhiteBold(16, letterSpacing: 4, heightSpacingMult: 1.5),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 16),
                FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Text(
                    message,
                    style: TextStyles.textWhite(14, heightSpacingMult: 1.3),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 48),
              ],
            ),
          );
  }

  _linkMeLayout() {
    return Container(
      height: 302,
      alignment: Alignment.center,
      child: FractionallySizedBox(
        widthFactor: isShowAppBarBg ? 0.75 : 0.85,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 65,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ARCUE UT VEL COMMODO", style: TextStyles.textWhiteBold(22, letterSpacing: 4, heightSpacingMult: 1.5)),
                  SizedBox(height: 24),
                  Text(
                    "Aliquam ut ex ut augue consectetur interdum endrerit imperdiet amet eleifend fringilla.",
                    style: TextStyles.textWhite(16, heightSpacingMult: 1.5),
                  ),
                ],
              ),
            ),
            Spacer(flex: 5),
            Expanded(
              flex: 30,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonTheme(
                    minWidth: double.infinity,
                    height: 48,
                    child: RaisedButton(
                      color: MyTheme.orange,
                      child: Text('ACTIVATE', style: TextStyles.textWhiteBold(isShowAppBarBg ? 14 : 12, isFontWeightBold: true)),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 22),
                  ButtonTheme(
                    minWidth: double.infinity,
                    height: 48,
                    child: OutlineButton(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      disabledBorderColor: Colors.grey,
                      highlightedBorderColor: Colors.red,
                      child: Text('LEARN MORE', style: TextStyles.textWhiteBold(isShowAppBarBg ? 14 : 10, isFontWeightBold: true)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _aboutLayout() {
    return AnimatedOpacity(
      opacity: 0.95,
      duration: Duration.zero,
      child: Container(
        height: isShowAppBarBg ? 278 : 190,
        color: MyTheme.bg_tab_bottom,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flag, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
                Icon(Icons.card_giftcard, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
                Icon(Icons.inbox, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
                Icon(Icons.face, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
                Icon(Icons.gradient_outlined, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
              ],
            ),
            SizedBox(height: 48),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: RichText(
                textAlign: TextAlign.center,
                strutStyle: StrutStyle(height: 1.4),
                text: TextSpan(
                  children: [
                    TextSpan(text: "© 2016, 2017 YOUR NAME  |  DESIGN: ", style: TextStyles.text(14, color: MyTheme.text_block_gray_light)),
                    TextSpan(text: "HTML5 UP  |  BUILT WITH: JEKYLL", style: TextStyles.text(14, color: MyTheme.text_block_gray_light)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
