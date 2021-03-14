import 'package:flutter/material.dart';
import 'package:lylblog/res/my_theme.dart';

class MyAppBar extends StatefulWidget {
  final Color? bgColor;
  final Widget? leftWidget;
  final Function? onLeftTap;
  final Widget? titleWidget;
  final Widget? rightWidget;
  final Function? onRightTap;
  final double iconWidth;
  final bool isShowStatusBar;

  const MyAppBar({
    Key? key,
    this.bgColor,
    this.leftWidget,
    this.onLeftTap,
    this.titleWidget,
    this.rightWidget,
    this.onRightTap,
    this.iconWidth = 40,
    this.isShowStatusBar = true,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isShowStatusBar ? MyTheme.status_bar_height + 44 : 44,
      padding: EdgeInsets.only(top: widget.isShowStatusBar ? MyTheme.status_bar_height : 0),
      color: widget.bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左
          SizedBox(width: 8),
          _leftWidget(),
          Expanded(child: Container()),
          // 中
          Offstage(
            offstage: widget.titleWidget == null,
            child: widget.titleWidget,
          ),
          Expanded(child: Container()),
          // 右
          _rightWidget(),
          SizedBox(width: 8),
        ],
      ),
    );
  }

  _leftWidget() {
    return GestureDetector(
      child: widget.leftWidget != null ? widget.leftWidget : Container(width: widget.iconWidth),
      onTap: () {
        if (widget.onLeftTap != null) widget.onLeftTap!();
      },
    );
  }

  _rightWidget() {
    return GestureDetector(
      child: widget.rightWidget != null ? widget.rightWidget : Container(width: widget.iconWidth),
      onTap: () {
        if (widget.onRightTap != null) widget.onRightTap!();
      },
    );
  }
}
