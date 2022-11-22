import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/save_load_mixin.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final hasDismissedSearchMessage = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final currentLocale = ValueNotifier<String?>(null)..addListener(scheduleSave);

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    hasDismissedSearchMessage.value = value['hasDismissedSearchMessage'] ?? false;
    currentLocale.value = value['currentLocale'];
  }

  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    await localeLogic.loadIfChanged(value);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'hasDismissedSearchMessage': hasDismissedSearchMessage.value,
      'currentLocale': currentLocale.value,
    };
  }
}
