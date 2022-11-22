import 'package:intl/intl_standalone.dart';
import 'package:wonders/common_libs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleLogic {
  static LocaleLogic get instance => LocaleLogic();

  AppLocalizations? _strings;
  AppLocalizations get strings => _strings!;

  bool get isLoaded => _strings != null;

  bool get isEnglish => strings.localeName == 'en';

  Future<void> load() async {
    final localeCode = settingsLogic.currentLocale.value ?? await findSystemLocale();
    Locale locale = Locale(localeCode.split('_')[0]);
    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = const Locale('en');
    }
    settingsLogic.currentLocale.value = locale.languageCode;
    _strings = await AppLocalizations.delegate.load(locale);
  }

  Future<void> loadIfChanged(Locale locale) async {
    bool didChange = _strings?.localeName != locale.languageCode;
    if (didChange && AppLocalizations.supportedLocales.contains(locale)) {
      _strings = await AppLocalizations.delegate.load(locale);
    }
  }
}
