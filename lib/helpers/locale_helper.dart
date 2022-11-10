import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_project/helpers/storage_helper.dart';

class LocaleHelper {
  static const fallbackLocale = localeDefault;

  static const localeDefault = localeEnUS;

  static const localeEnUS = Locale('en', 'US');

  static const localeZhCN = Locale('zh', 'CN');

  static String getLocaleKey(Locale locale) => locale.toString();
  static String getAppLocaleKey(Locale locale) =>
      StorageHelper.retrieveAppLocaleKey();

  static String followSystemLocaleKey = 'follow_system';

  static List<LocaleOption> localeData = [
    LocaleOption(followSystemLocaleKey, Get.deviceLocale!, 'Follow System'),
    LocaleOption(getLocaleKey(localeEnUS), localeEnUS, 'English'),
    LocaleOption(getLocaleKey(localeZhCN), localeZhCN, 'Chinese'),
  ];

  static Locale get appLocale {
    Locale locale = localeData
        .firstWhere((element) =>
            element.localeKey == StorageHelper.retrieveAppLocaleKey())
        .locale;
    return locale;
  }

  static String get appLocaleName {
    String appLocaleKey = StorageHelper.retrieveAppLocaleKey();

    return localeData.firstWhere((element) {
      return element.localeKey == appLocaleKey;
    }).name;
  }
}

class LocaleOption {
  final String localeKey;
  final Locale locale;
  final String name;

  LocaleOption(this.localeKey, this.locale, this.name);
}
