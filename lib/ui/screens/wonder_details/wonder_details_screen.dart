import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/lazy_indexed_stack.dart';
import 'package:wonders/ui/common/measurable_widget.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_details_tab_menu.dart';

class WonderDetailsScreen extends StatefulWidget {
  const WonderDetailsScreen({Key? key, required this.type, required this.initialTabIndex}) : super(key: key);
  final WonderType type;
  final int initialTabIndex;

  @override
  WonderDetailsScreenState createState() => WonderDetailsScreenState();
}

class WonderDetailsScreenState extends State<WonderDetailsScreen> with SingleTickerProviderStateMixin {
  // 监听并刷新页面
  late final _tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: widget.initialTabIndex,
  )..addListener(_handleTabChanged);

  double? _tabBarHeight;

  void _handleTabChanged() {
    setState(() {});
  }

  void _handleTabMenuSized(Size size) {
    setState(() => _tabBarHeight = size.height - WonderDetailsTabMenu.buttonInset);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wonder = wondersLogic.getData(widget.type);
    final tabBarHeight = _tabBarHeight ?? 0;
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          // tab展示的页面内容
          LazyIndexedStack(
            index: _tabController.index,
            children: [
              Padding(padding: EdgeInsets.only(bottom: tabBarHeight), child: Container(color: $styles.colors.white,)),
              Padding(padding: EdgeInsets.only(bottom: tabBarHeight), child: Container(color: $styles.colors.white,)),
              Padding(padding: EdgeInsets.only(bottom: tabBarHeight), child: Container(color: $styles.colors.white,)),
              Padding(padding: EdgeInsets.only(bottom: tabBarHeight), child: Container(color: $styles.colors.white,)),
            ],
          ),

          // 底部tab按钮
          BottomCenter(
            child: MeasurableWidget(
              onChange: _handleTabMenuSized,
              child: WonderDetailsTabMenu(
                tabController: _tabController,
                wonderType: wonder.type,
                showBg: true,
                showHomeBtn: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
