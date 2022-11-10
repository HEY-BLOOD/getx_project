import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:getx_project/app/routes/app_pages.dart';
import 'package:getx_project/helpers/notification_helper.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:getx_project/helpers/locale_helper.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  // static late bool initialValue;
  @override
  Widget build(BuildContext context) {
    // initialValue = controller.doIt.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsView'),
        centerTitle: true,
      ),
      body:
          // GetX<SettingsController>(
          //   init: SettingsController(),
          //   builder: (controller) => buildSettingsList(controller),
          // ),
          buildSettingsList(controller),
    );
  }

  SettingsList buildSettingsList(SettingsController controller) {
    return SettingsList(
      platform: DevicePlatform.android,
      sections: [
        SettingsSection(
          title: const Text('General'),
          tiles: [
            SettingsTile.navigation(
              title: const Text('Navigation to Onboarding'),
              leading: const Icon(Icons.navigation),
              description:
                  const Text('Navigation to Onboarding page using GetX'),
              onPressed: (context) {
                Get.toNamed(Routes.ONBOARDING);
              },
            ),
            SettingsTile.switchTile(
              initialValue: true,
              onToggle: (value) {
                controller.onToggle(value);
              },
              title: Obx(
                  () => Text('Whether do something: ${controller.doIt.value}')),
              description:
                  const Text('Please only use Get.toNamed() for navigation.'),
            ),
            SettingsTile(
              title: Text('language'.tr),
              leading: const Icon(Icons.language),
              description: Text(LocaleHelper.appLocaleName),
              onPressed: (context) {
                _showLanguageDialog(context);
              },
            ),
            SettingsTile(
              title: const Text('Awesome Notifications'),
              leading: const Icon(Icons.notifications),
              description: const Text('Push a local notifications'),
              onPressed: (context) {
                AwesomeNotificationHelper.createNotification();
              },
            ),
            SettingsTile(
              title: const Text('Flutter Local Notifications'),
              leading: const Icon(Icons.notifications),
              description: const Text('Push a local notifications'),
              onPressed: (context) {
                _initializeNotifications();
              },
            ),
            SettingsTile(
              title: const Text('Login'),
              leading: const Icon(Icons.login),
              onPressed: (context) {
                Get.toNamed(Routes.LOGIN);
              },
            ),
            SettingsTile(
              title: const Text('About'),
              leading: const Icon(Icons.info),
              onPressed: (context) {},
            ),
          ],
        ),
      ],
    );
  }

  Future<int?> _showLanguageDialog(context) async {
    final languageIndex = controller.readlanguageIndex();

    final result = await showConfirmationDialog<int>(
      context: context,
      title: 'Language',
      message: 'Choose a language to use:',
      actions: [
        ...List.generate(
          controller.languageData.length,
          (index) => AlertDialogAction(
            label: controller.languageData.elementAt(index).name,
            key: index,
          ),
        ),
      ],
      barrierDismissible: false,
      initialSelectedActionKey: languageIndex,
    );

    controller.updateLanguage(
        controller.languageData.elementAt(result ?? languageIndex));

    // Get.snackbar("title", "the value is ${result ?? languageIndex}");
    return result;
  }

  /**
   * flutter_local_notifications
   */
  Future<void> _initializeNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('splash');
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // final MacOSInitializationSettings initializationSettingsMacOS =
    //     MacOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('default', 'Default channel',
            channelDescription: 'This is a default channel',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Notification title',
        'Click to show the payload in a snackbar', platformChannelSpecifics,
        payload: 'item x');
  }

  void _onSelectNotification(String? payload) {
    Get.snackbar('onSelectNotification', payload ?? "none");
  }
}
