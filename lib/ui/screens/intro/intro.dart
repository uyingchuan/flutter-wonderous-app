import 'package:wonders/common_libs.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        child: const Text('Hello Flutter!'),
      ),
    );
  }
}
