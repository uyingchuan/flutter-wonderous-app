import 'package:wonders/common_libs.dart';

class WonderDetailsTabMenu extends StatelessWidget {
  static double buttonInset = 12;
  static double bottomPadding = 0;

  const WonderDetailsTabMenu(
      {Key? key,
    required this.tabController,
    required this.showBg,
    required this.showHomeBtn,
    required this.wonderType,
  }) : super(key: key);

  final TabController tabController;
  final bool showBg;
  final WonderType wonderType;
  final bool showHomeBtn;

  @override
  Widget build(BuildContext context) {
    Color iconColor = showBg ? $styles.colors.black : $styles.colors.white;
    bottomPadding = max(context.mq.padding.bottom, $styles.insets.xs * 1.5);
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(top: buttonInset),
            child: ColoredBox(color: $styles.colors.offWhite),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: $styles.insets.sm, right: $styles.insets.xxs, bottom: bottomPadding),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _TabBtn(0, tabController,
                      iconImg: 'editorial', color: iconColor, label: 'label'),
                  _TabBtn(1, tabController,
                      iconImg: 'photos', color: iconColor, label: 'label'),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class _TabBtn extends StatelessWidget {
  const _TabBtn(
      this.index,
      this.tabController, {
        Key? key,
        required this.iconImg,
        required this.color,
        required this.label,
      }) : super(key: key);

  final int index;
  final TabController tabController;
  final String iconImg;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    bool selected = tabController.index == index;

    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final iconImgPath = '${ImagePaths.common}/tab-$iconImg${selected ? '-active' : ''}.png';
    String tabLabel = localizations.tabLabel(tabIndex: index + 1, tabCount: tabController.length);
    tabLabel = '$label: $tabLabel';
    return Expanded(
      child: MergeSemantics(
        child: Semantics(
          selected: selected,
          label: tabLabel,
          child: ExcludeSemantics(
            child: AppBtn.basic(
              padding: EdgeInsets.only(top: $styles.insets.md + $styles.insets.xs, bottom: $styles.insets.sm),
              onPressed: () => tabController.index = index,
              semanticLabel: label,
              child: Stack(
                children: [
                  Image.asset(iconImgPath, height: 32, width: 32, color: selected ? null : color),
                  if (selected)
                    Positioned.fill(
                      child: BottomCenter(
                        child: Transform.translate(
                          offset: Offset(0, $styles.insets.xxs),
                          child: Animate().custom(
                            curve: Curves.easeOutCubic,
                            end: 24,
                            builder: (_, v, __) => Container(height: 3, width: v, color: $styles.colors.accent1),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
