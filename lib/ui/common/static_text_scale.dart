import 'package:wonders/common_libs.dart';

// 设置文字像素比
class StaticTextScale extends StatelessWidget {
  const StaticTextScale({Key? key, required this.child, this.scale = 1.0}) : super(key: key);

  final Widget child;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
      child: child,
    );
  }
}
