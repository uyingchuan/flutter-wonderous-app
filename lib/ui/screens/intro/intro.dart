import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/app_page_indicator.dart';
import 'package:wonders/ui/common/controls/circle_buttons.dart';
import 'package:wonders/ui/common/static_text_scale.dart';
import 'package:wonders/ui/common/themed_text.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static const double _imageSize = 264;
  static const double _logoHeight = 126;
  static const double _textHeight = 155;
  static const double _pageIndicatorHeight = 55;

  static List<_PageData> pageData = [];

  late final PageController _pageController = PageController()..addListener(_handlePageChanged);
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  void _handlePageChanged() {
    int newPage = _pageController.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  void _handleIntroCompletePressed() {
    if (_currentPage.value == pageData.length - 1) {
      context.push(ScreenPaths.wonderDetails(wondersLogic.all[0].type));
      settingsLogic.hasCompletedOnboarding.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    pageData = [
      _PageData($strings.introTitleJourney, $strings.introDescriptionNavigate, 'camel', '1'),
      _PageData($strings.introTitleExplore, $strings.introDescriptionUncover, 'petra', '2'),
      _PageData($strings.introTitleDiscover, $strings.introDescriptionLearn, 'statue', '3'),
    ];

    final List<Widget> pages = pageData.map((e) => _Page(data: e)).toList();

    final Widget content = Stack(children: [
      MergeSemantics(
        child: Semantics(
          child: PageView(
            controller: _pageController,
            children: pages,
          ),
        ),
      ),

      // IgnorePointer 阻止手势监听
      IgnorePointer(
        ignoringSemantics: false,
        child: Column(children: [
          Spacer(),

          // logo
          Semantics(
            header: true,
            child: Container(
              height: _logoHeight,
              alignment: Alignment.center,
              child: const _WonderousLogo(),
              // child: _Won,
            ),
          ),

          // 上层遮罩
          SizedBox(
            height: _imageSize,
            width: _imageSize,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: $styles.times.slow,
                  child: KeyedSubtree(
                    key: ValueKey(value),
                    child: _PageImage(data: pageData[value]),
                  ),
                );
              },
            ),
          ),

          const Gap(_IntroScreenState._textHeight),

          Container(
            height: _pageIndicatorHeight,
            alignment: const Alignment(0.0, -0.75),
            child: AppPageIndicator(
              count: pageData.length,
              controller: _pageController,
              color: $styles.colors.offWhite,
            ),
          ),

          const Spacer(flex: 2),
        ]),
      ),

      Positioned(
        right: $styles.insets.lg,
        bottom: $styles.insets.lg,
        child: _buildFinishBtn(context),
      )
    ]);

    return DefaultTextColor(
      color: $styles.colors.offWhite,
      child: Container(
        color: $styles.colors.black,
        child: SafeArea(child: content.animate().fadeIn(delay: 1500.ms)),
      ),
    );
  }

  Widget _buildFinishBtn(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 1 : 0,
          duration: $styles.times.fast,
          child: CircleIconBtn(
            icon: AppIcons.next_large,
            bgColor: $styles.colors.accent1,
            semanticLabel: $strings.introSemanticEnterApp,
            onPressed: _handleIntroCompletePressed,
          ),
        );
      },
    );
  }
}

@immutable
class _PageData {
  const _PageData(this.title, this.desc, this.img, this.mask);

  final String title;
  final String desc;
  final String img;
  final String mask;
}

class _Page extends StatelessWidget {
  const _Page({Key? key, required this.data}) : super(key: key);

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Column(
        children: [
          // Flex容器内的占位空组件
          const Spacer(),

          // Row/Column内替代空SizedBox的一种方式
          const Gap(_IntroScreenState._imageSize + _IntroScreenState._logoHeight),

          SizedBox(
            height: _IntroScreenState._textHeight,
            width: _IntroScreenState._imageSize + $styles.insets.md,
            child: StaticTextScale(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data.title, style: $styles.text.wonderTitle.copyWith(fontSize: 24)),
                  Gap($styles.insets.sm),
                  Text(data.desc, style: $styles.text.body, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),

          const Gap(_IntroScreenState._pageIndicatorHeight),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class _WonderousLogo extends StatelessWidget {
  const _WonderousLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExcludeSemantics(
          child: SvgPicture.asset(SvgPaths.compassSimple, color: $styles.colors.offWhite, height: 48),
        ),
        Gap($styles.insets.xs),
        StaticTextScale(
          child: Text(
            $strings.introSemanticWonderous,
            style: $styles.text.wonderTitle.copyWith(fontSize: 32, color: $styles.colors.offWhite),
          ),
        )
      ],
    );
  }
}

class _PageImage extends StatelessWidget {
  const _PageImage({Key? key, required this.data}) : super(key: key);

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox.expand(
        child: Image.asset(
          '${ImagePaths.common}/intro-${data.img}.jpg',
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
        ),
      ),
      Positioned.fill(
        child: Image.asset('${ImagePaths.common}/intro-mask-${data.mask}.png', fit: BoxFit.fill),
      ),
    ]);
  }
}

