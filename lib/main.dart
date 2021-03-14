// @dart=2.9

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:lylblog/my_app.dart';

import 'config/config.dart';
import 'page/home/home_page.dart';
import 'res/my_theme.dart';
import 'utils/shared_preferences.dart';

void main() {
  runApp(MyAppPage());

  _init();
}

_init() async {
  await SpUtil.init();

  _initLeanCloud();
}

void _initLeanCloud() {
  // 国际版应用（App ID 后缀为 -MdYXbMMI）没有绑定自定义域名，初始化 SDK 时不用传入服务器地址参数。
  LeanCloud.initialize(
    MyApp.config[Config.LC_APP_ID],
    MyApp.config[Config.LC_APP_KEY],
    server: "https://ie8n1u3h.lc-cn-n1-shared.com",
    // queryCache: new LCQueryCache(),
  );

  if (MyApp.env == ENV.DEV) {
    LCLogger.setLevel(LCLogger.DebugLevel);
  }
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
