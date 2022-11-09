import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:wonders/common_libs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 在app初始化之前保持住启动页面
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const WondersApp());
  await appLogic.bootstrap();

  // 引导程序结束后移除启动页
  FlutterNativeSplash.remove();
}

class WondersApp extends StatelessWidget {
  const WondersApp({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

AppLogic get appLogic => AppLogic.instance;
