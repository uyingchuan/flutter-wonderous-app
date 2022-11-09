import 'package:wonders/common_libs.dart';
import 'package:flutter/cupertino.dart';
import 'package:wonders/ui/app_scaffold.dart';
import 'package:wonders/ui/screens/intro/intro.dart';

class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
}

final appRouter = GoRouter(
  redirect: _handleRedirect,
  routes: [
    ShellRoute(
      builder: (_, __, child) {
        return WondersAppScaffold(child: child);
      },
      routes: [
        AppRoute(ScreenPaths.splash, (_) => Container(color: $styles.colors.greyStrong)),
        AppRoute(ScreenPaths.intro, (_) => const IntroScreen()),
      ],
    )
  ],
);

String? _handleRedirect(_, GoRouterState state) {
  // 在初始化完成之前停留在splash页面
  if (!appLogic.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to ${state.location}');
  return null;
}

class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
    path: path,
    routes: routes,
    pageBuilder: (context, state) {
      final pageContent = Scaffold(
        body: builder(state),
        resizeToAvoidBottomInset: false,
      );
      if (useFade) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: pageContent,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      }
      return CupertinoPage(child: pageContent);
    },
  );
  final bool useFade;
}
