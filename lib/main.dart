import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:wonders/common_libs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wonders/logic/locale_logic.dart';
import 'package:wonders/logic/settings_logic.dart';
import 'package:wonders/logic/wonder_logic.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 在app初始化之前保持住启动页面
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  registerSingletons();
  runApp(WondersApp());
  await appLogic.bootstrap();

  // 引导程序结束后移除启动页
  FlutterNativeSplash.remove();
}

class WondersApp extends StatelessWidget with GetItMixin {
  WondersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    return MaterialApp.router(
      locale: locale == null ? null : Locale(locale),
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

void registerSingletons() {
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
  GetIt.I.registerLazySingleton<WondersLogic>(() => WondersLogic());
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  GetIt.I.registerLazySingleton<LocaleLogic>(() => LocaleLogic());
}

AppLogic get appLogic => GetIt.I.get<AppLogic>();
WondersLogic get wondersLogic => GetIt.I.get<WondersLogic>();
SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();
LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();
AppLocalizations get $strings => localeLogic.strings;
