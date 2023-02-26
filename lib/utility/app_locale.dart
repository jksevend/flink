import 'package:flink/utility/constants.dart';
import 'package:flutter/material.dart';

/// Helper for all supported locales in this game
enum AppLocale { german, english }

extension AppLocaleExtension on AppLocale {

  Locale get locale => _locale(this);
  String get localeFlag => _localeFlag(this);

  String get translationKey => _translationKey(this);

  Locale _locale(final AppLocale appLocale) {
    switch (appLocale) {
      case AppLocale.german:
        return const Locale('de', 'DE');
      case AppLocale.english:
        return const Locale('en', 'US');
    }
  }

  /// Returns the path to a flag image of a given [appLocale]
  String _localeFlag(final AppLocale appLocale) {
    switch (appLocale) {
      case AppLocale.german:
        return Assets.germanyIcon;
      case AppLocale.english:
        return Assets.usIcon;
    }
  }

  /// Translation key for a [appLocale] located in assets/lang/
  String _translationKey(final AppLocale appLocale) {
    switch (appLocale) {
      case AppLocale.german:
        return 'german';
      case AppLocale.english:
        return 'english';
    }
  }
}
