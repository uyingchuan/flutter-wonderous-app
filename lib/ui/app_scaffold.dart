import 'package:wonders/common_libs.dart';

class WondersAppScaffold extends StatelessWidget {
  const WondersAppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Theme(
          data: ThemeData(),
          child: child,
        )
      ],
    );
  }
}
