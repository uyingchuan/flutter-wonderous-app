import 'package:wonders/common_libs.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({
    Key? key,
    required this.onPressed,
    this.bgColor,
    this.border,
    required this.child,
    this.size,
    required this.semanticLabel,
  }) : super(key: key);

  static double defaultSize = 48;

  final VoidCallback onPressed;
  final Color? bgColor;
  final BorderSide? border;
  final Widget child;
  final double? size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    double sz = size ?? defaultSize;
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      minimumSize: Size(sz, sz),
      padding: EdgeInsets.zero,
      circular: true,
      bgColor: bgColor,
      border: border,
      child: child,
    );
  }
}


class CircleIconBtn extends StatelessWidget {
  const CircleIconBtn({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.border,
    this.bgColor,
    this.color,
    required this.semanticLabel,
    this.size,
    this.iconSize,
  }) : super(key: key);

  static double defaultSize = 28;

  final AppIcons icon;
  final VoidCallback onPressed;
  final BorderSide? border;
  final Color? bgColor;
  final Color? color;
  final String semanticLabel;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = $styles.colors.greyStrong;
    Color iconColor = color ?? $styles.colors.offWhite;
    return CircleBtn(
      onPressed: onPressed,
      border: border,
      size: size,
      bgColor: bgColor ?? defaultColor,
      semanticLabel: semanticLabel,
      child: AppIcon(icon: icon, size: iconSize ?? defaultSize, color: iconColor),
    );
  }
}

