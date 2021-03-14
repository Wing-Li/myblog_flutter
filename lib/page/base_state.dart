import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';
import 'package:lylblog/utils/my_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  bool isPageVisible = true;
  bool isDispose = false;

  bool isWideScreen = true;
  double pageHeight = 946.0;

  @override
  void initState() {
    isDispose = false;
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  updatePageSize() {
    isWideScreen = MyUtils.getScreenWidth(context) >= 762;
    pageHeight = MyUtils.getScreenHeight(context);
  }

  @override
  void dispose() {
    isDispose = true;
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void deactivate() {
    isPageVisible = !isPageVisible;
    if (isPageVisible) {
      //onResume
      onResumed();
    } else {
      //onStop
      onStop();
    }
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.inactive:
        onStop();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  void onResumed() {}

  void onPaused() {}

  void onStop() {}

  // Future<bool> checkVip() async {
  //   return await PayUtils.isVip();
  // }

  // =================================== ↓ 下拉刷新与上拉加载 ↓ ==========================================
  RefreshController _mRefreshController = RefreshController(initialRefresh: false);

  // 3. 需子类重写
  void dataClear() {}

  // 2. 需子类重写
  Future<int> fetchData() async {
    return 0;
  }

  void onRefreshData() async {
    dataClear();
    var resultSize = await fetchData();

    _mRefreshController.resetNoData();
    setState(() {
      _mRefreshController.refreshCompleted();
    });
  }

  void _onLoadingData() async {
    var resultSize = await fetchData();

    if (resultSize > 0) {
      _mRefreshController.loadComplete();
    } else if (resultSize == -1) {
      _mRefreshController.loadFailed();
    } else {
      _mRefreshController.loadNoData();
    }
  }

  // 1. 先写 ListView
  Widget RefresherView(
    Widget child, {
    bool enablePullUp = true,
    bool enablePullDown = true,
  }) {
    return SmartRefresher(
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      controller: _mRefreshController,
      onRefresh: onRefreshData,
      onLoading: _onLoadingData,
      child: child,
    );
  }

  // =================================== ↑ 下拉刷新与上拉加载 ↑ ==========================================

  // =================================== ↓ 常用自定义组件 ↓ ==========================================

  Widget RoundButton(String text, {Function()? onTap, Color? backgroundColor, Color? textColor, bool isFullWidth = true}) {
    return ButtonTheme(
      height: 52,
      minWidth: isFullWidth ? double.infinity : 0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: backgroundColor == null ? MyTheme.main : backgroundColor,
        // elevation: 1,
        highlightElevation: 0,
        disabledElevation: 0,
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyles.base(
            size: 16,
            color: textColor == null ? MyTheme.white : textColor,
            isFontWeightBold: true,
            isBold: false,
          ),
        ),
      ),
    );
  }

// =================================== ↑ 常用自定义组件 ↑ ==========================================
}
