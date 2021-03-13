import 'package:shared_preferences/shared_preferences.dart';

SpUtil spUtil = new SpUtil();

/// 用来做shared_preferences的存储
class SpUtil {
  static late SharedPreferences _spf;

  // 在使用之前初始化
  static Future init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set keys = getKeys() ?? Set();
    return keys.contains(key);
  }

  Set<String>? getKeys() {
    if (_beforeCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return null;
    return _spf.getString(key);
  }

  Future<bool>? putString(String key, String value) {
    if (_beforeCheck()) return Future(() => false);
    return _spf.setString(key, value);
  }

  bool getBool(String key) {
    if (_beforeCheck()) return false;
    return _spf.getBool(key) ?? false;
  }

  Future<bool> putBool(String key, bool value) {
    if (_beforeCheck()) return Future(() => false);
    return _spf.setBool(key, value);
  }

  int getInt(String key) {
    if (_beforeCheck()) return 0;
    return _spf.getInt(key) ?? 0;
  }

  Future<bool> putInt(String key, int value) {
    if (_beforeCheck()) return Future(() => false);
    return _spf.setInt(key, value);
  }

  double getDouble(String key) {
    if (_beforeCheck()) return 0.0;
    return _spf.getDouble(key) ?? 0.0;
  }

  double getDoubleDefault(String key, double defaultNumber) {
    if (_beforeCheck()) return 0.0;
    var number = _spf.getDouble(key);
    if (number == null) {
      return defaultNumber;
    } else {
      return number;
    }
  }

  Future<bool> putDouble(String key, double value) {
    if (_beforeCheck()) return Future(() => false);
    return _spf.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _spf.getStringList(key) ?? [];
  }

  Future<bool> putStringList(String key, List<String> value) {
    if (_beforeCheck()) return Future(() => false);
    return _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  Future<bool> remove(String key) {
    if (_beforeCheck()) return Future(() => false);
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforeCheck()) return Future(() => false);
    return _spf.clear();
  }
}
