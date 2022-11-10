import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:getx_project/helpers/locale_helper.dart';

class StorageHelper {
  static final GetStorage _box = GetStorage();

  static const languageSavingKey = "language_key";

  static Future<void> updateLocale(LocaleOption localeOption) async {
    await updateLocaleKey(localeOption.localeKey);

    Get.updateLocale(localeOption.locale);
  }

  static Future<void> updateLocaleKey(String localeKey) async {
    await _box.writeIfNull(
        languageSavingKey, LocaleHelper.followSystemLocaleKey);
    await _box.write(languageSavingKey, localeKey);
  }

  static String retrieveAppLocaleKey() {
    String? localeString = _box.read(languageSavingKey);

    // localeString != null ? localeString : LocaleHelper.followSystemLocaleKey;
    return localeString ?? LocaleHelper.followSystemLocaleKey;
  }
}
