import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'zh_CN': _zhCNLanguage,
      'en_US': _enUSLanguage,
      // add your language here
    };
  }
}

const _zhCNLanguage = {
  'hello': '你好',
  'welcome': '欢迎',
  'language': '语言',
  'loading': '加载中……',
  'playbackSpeed': '播放速度',
  'subtitles': '字幕',
  'cancel': '取消',
};

const _enUSLanguage = {
  'hello': 'Hello',
  'welcome': 'Welcome',
  'language': 'Language',
  'loading': 'Loading...',
  'playbackSpeed': 'Playback Speed',
  'subtitles': 'Subtitles',
  'cancel': 'Cancel',
};
