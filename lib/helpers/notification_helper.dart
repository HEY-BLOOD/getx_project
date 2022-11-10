import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class AwesomeNotificationHelper {
  static const basicChannelKey = 'basic_channel';
  static const basicChannelGroupKey = 'basic_channel_group';
  static const basicChannelName = 'Basic notifications';
  static const basicChannelDescription =
      'Notification channel for basic notifications';

  static final channelGroups = [
    NotificationChannelGroup(
      channelGroupkey: basicChannelGroupKey,
      channelGroupName: 'Basic group',
    ),
  ];

  static final channels = [
    NotificationChannel(
      channelGroupKey: basicChannelGroupKey,
      channelKey: basicChannelKey,
      channelName: basicChannelName,
      channelDescription: basicChannelDescription,
      defaultColor: const Color(0xFF9D50DD),
      ledColor: Colors.white,
      importance: NotificationImportance.High,
    )
  ];

  static Future<void> createNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: basicChannelKey,
        title: 'notification title',
        body:
            'Qui fugit provident. Enim placeat voluptatem commodi deserunt quia sit sunt numquam magnam.\nLabore aliquid est et. Voluptates cumque sit asperiores velit hic.',
        bigPicture:
            'https://tecnoblog.net/wp-content/uploads/2019/09/emoji.jpg',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }
}
