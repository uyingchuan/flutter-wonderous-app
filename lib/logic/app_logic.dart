import 'package:wonders/common_libs.dart';

class AppLogic {
  static AppLogic instance = AppLogic();

  /// App初始化完成的标志,用来阻止router在初始化完成之前跳转
  bool isBootstrapComplete = false;

  /// 执行初始化相关操作，加载配置，注册services等
  Future<void> bootstrap() async {

    // 初始化settings
    await settingsLogic.load();

    // 初始化locale
    await localeLogic.load();

    // 初始化Wonders Data
    wondersLogic.init();

    // 初始化结束
    isBootstrapComplete = true;

    // 初始化操作结束后跳转相应页面
    appRouter.go(ScreenPaths.intro);
  }
}