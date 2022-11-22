import 'package:wonders/common_libs.dart';

class AppBtn extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppBtn({
    Key? key,
    required this.onPressed,
    this.enableFeedback = true,
    required this.semanticLabel,
    this.child,
    this.padding,
    this.expand = false,
    this.circular = false,
    this.minimumSize,
    this.isSecondary = false,
    this.border,
    this.bgColor,
    this.pressEffect = true,
  })  : _builder = null,
        super(key: key);

  // ignore: prefer_const_constructors_in_immutables
  AppBtn.basic({
    Key? key,
    required this.onPressed,
    this.enableFeedback = true,
    required this.semanticLabel,
    this.child,
    this.padding = EdgeInsets.zero,
    this.circular = false,
    this.minimumSize,
    this.isSecondary = false,
    this.pressEffect = true,
  })  : _builder = null,
        bgColor = Colors.transparent,
        border = null,
        expand = false,
        super(key: key);

  // interaction
  final VoidCallback onPressed;
  final bool enableFeedback;
  late final String semanticLabel;

  // content:
  late final Widget? child;
  late final WidgetBuilder? _builder;

  // layout:
  final EdgeInsets? padding;
  final bool expand;
  final bool circular;
  final Size? minimumSize;

  // style:
  final bool isSecondary;
  final BorderSide? border;
  final Color? bgColor;
  final bool pressEffect;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = isSecondary ? $styles.colors.white : $styles.colors.greyStrong;
    Color textColor = isSecondary ? $styles.colors.black : $styles.colors.white;
    BorderSide side = border ?? BorderSide.none;

    Widget content = _builder?.call(context) ?? child ?? const SizedBox.shrink();
    if (expand) content = Center(child: content);

    OutlinedBorder shape = circular
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(side: side, borderRadius: BorderRadius.circular($styles.corners.md));

    ButtonStyle style = ButtonStyle(
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize ?? Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashFactory: NoSplash.splashFactory,
      backgroundColor: ButtonStyleButton.allOrNull<Color>(bgColor ?? defaultColor),
      overlayColor: ButtonStyleButton.allOrNull<Color>(Colors.transparent), // disable default press effect
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding ?? EdgeInsets.all($styles.insets.md)),
      enableFeedback: enableFeedback,
    );

    Widget button = TextButton(
      onPressed: () => onPressed(),
      style: style,
      child: DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(color: textColor),
        child: content,
      ),
    );

    if (pressEffect) button = _ButtonPressEffect(button);

    if (semanticLabel.isEmpty) return button;
    return Semantics(
      label: semanticLabel,
      button: true,
      container: true,
      child: ExcludeSemantics(child: button),
    );
  }
}

/// 添加一个透明度变化的点击效果
class _ButtonPressEffect extends StatefulWidget {
  const _ButtonPressEffect(this.child, {Key? key}) : super(key: key);
  final Widget child;

  @override
  State<_ButtonPressEffect> createState() => _ButtonPressEffectState();
}

class _ButtonPressEffectState extends State<_ButtonPressEffect> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTapDown: (_) => setState(() => _isDown = true),
      onTapUp: (_) => setState(() => _isDown = false), // not called, TextButton swallows this.
      onTapCancel: () => setState(() => _isDown = false),
      behavior: HitTestBehavior.translucent,
      child: Opacity(
        opacity: _isDown ? 0.7 : 1,
        child: ExcludeSemantics(child: widget.child),
      ),
    );
  }
}
