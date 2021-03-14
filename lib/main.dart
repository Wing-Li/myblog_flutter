// @dart=2.9

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'page/home/home_page.dart';
import 'res/my_theme.dart';
import 'utils/shared_preferences.dart';

void main() {
  runApp(MyAppPage());

  _init();
}

_init() async {
  await SpUtil.init();
}

class MyAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      MyTheme.status_bar_height = MediaQuery.of(context).padding.top;
      MyTheme.bottom_bar_height = MediaQuery.of(context).padding.bottom;
    } catch (e) {
      MyTheme.status_bar_height = 0.0;
      MyTheme.bottom_bar_height = 0.0;
    }

    return MaterialApp(
      title: 'Wing_Li',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: BotToastInit(),
      //1.调用BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      //2.注册路由观察者
      home: HomePage(),
    );
  }
}
