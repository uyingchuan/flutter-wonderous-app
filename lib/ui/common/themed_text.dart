import 'package:wonders/common_libs.dart';

class DefaultTextColor extends StatelessWidget {
  const DefaultTextColor({Key? key, required this.color, required this.child}) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(color: color),
      child: child,
    );
  }
}

