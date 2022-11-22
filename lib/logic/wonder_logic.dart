import 'package:wonders/logic/data/great_wall_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/common_libs.dart';

class WondersLogic {
  static WondersLogic get instance => WondersLogic();

  List<WonderData> all = [];

  WonderData getData(WonderType value) {
    WonderData? result = all.firstWhereOrNull((w) => w.type == value);
    if (result == null) throw ('Could not find data fro wonder type $value');
    return result;
  }

  void init() {
    all = [
      GreatWallData(),
    ];
  }
}