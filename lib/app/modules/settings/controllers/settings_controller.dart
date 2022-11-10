import 'dart:ui';

import 'package:get/get.dart';

import 'package:getx_project/helpers/locale_helper.dart';
import 'package:getx_project/helpers/storage_helper.dart';

class SettingsController extends GetxController {
  final languageData = LocaleHelper.localeData;
  final doIt = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onToggle(bool value) => doIt.value = value;

  int readlanguageIndex() {
    return languageData.indexWhere((element) {
      return element.localeKey == StorageHelper.retrieveAppLocaleKey();
    });
  }

  void updateLanguage(LocaleOption localeOption) {
    StorageHelper.updateLocale(localeOption);
  }
}

class LanguageOption {
  final String name;
  final Locale locale;

  LanguageOption(this.name, this.locale);
}
