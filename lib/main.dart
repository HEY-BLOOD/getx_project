import 'package:appwrite/appwrite.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:getx_project/helpers/locale_helper.dart';
import 'package:getx_project/helpers/notification_helper.dart';
import 'package:getx_project/languages.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/routes/app_pages.dart';
import 'constants/app_constants.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });

  await GetStorage.init();

  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  // Initialize Notification and Channels
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    // 'resource://drawable/res_app_icon',
    null,
    AwesomeNotificationHelper.channels,
    // Channel groups are only visual and are not required
    channelGroups: AwesomeNotificationHelper.channelGroups,
    debug: true,
  );

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  debugPrint(
      "appname: $appName\npackageName: $packageName\nversion: $version\nbuildNumber: $buildNumber");

  Client client = Client();
  client
      .setEndpoint(AppConstans.appwriteEndpoint)
      .setProject(AppConstans.appwriteProjectId);
  Account account = Account(client);

  runApp(
    DevicePreview(
      // enabled: !kReleaseMode,
      builder: (context) => GetMaterialApp(
        useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        translations: Languages(),
        locale: LocaleHelper.appLocale,
        fallbackLocale: LocaleHelper.fallbackLocale,
        title: appName,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        debugShowCheckedModeBanner: false,
      ), // Wrap your app
    ),
  );
}
