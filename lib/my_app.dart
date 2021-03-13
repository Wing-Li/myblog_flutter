import 'package:event_bus/event_bus.dart';
import 'package:flutter/services.dart';

import 'config/config.dart';
import 'utils/shared_preferences.dart';

enum ENV {
  DEV,
  PRODUCTION,
}

class MyApp {
  /// 通过Application设计环境变量
  static ENV env = ENV.DEV;
  static EventBus eventBus = EventBus();
  static bool isAd = false;

  /// 所有获取配置的唯一入口
  static Map<String, String> get config {
    if (MyApp.env == ENV.DEV) {
      return {
        Config.BASE_URL: '',
      };
    }
    if (MyApp.env == ENV.PRODUCTION) {
      return {
        Config.BASE_URL: '',
      };
    }
    return {};
  }

  static getPath() {}

  static exitApp() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
