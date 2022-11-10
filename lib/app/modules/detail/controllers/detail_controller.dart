import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DetailController extends GetxController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  BetterPlayerController? betterPlayerController;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // initChewiePlayer();
    // initBatterPlayer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController.dispose();
    chewieController?.dispose();
    betterPlayerController?.dispose();
  }

  void increment() => count.value++;

  initBatterPlayer() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");

    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        controlsConfiguration: BetterPlayerControlsConfiguration(
          textColor: Colors.black,
          iconsColor: Colors.black,
        ),
        aspectRatio: 16 / 9,
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  Future<void> initChewiePlayer() async {
    videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    await Future.wait([videoPlayerController.initialize()]);

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      // allowFullScreen: false,
      materialProgressColors: ChewieProgressColors(
          // playedColor: Colors.red,
          // handleColor: Colors.cyanAccent,
          // backgroundColor: Colors.yellow,
          // bufferedColor: Colors.lightGreen,
          ),
      placeholder: Container(
        color: Colors.black,
      ),
      errorBuilder: (context, errorMessage) =>
          Center(child: Text(errorMessage)),
      subtitle: Subtitles([
        Subtitle(
          index: 0,
          start: Duration.zero,
          end: const Duration(seconds: 4),
          text: 'Hello from subtitles',
        ),
        Subtitle(
          index: 1,
          start: const Duration(seconds: 4),
          end: const Duration(seconds: 7),
          text: 'Whats up? :)',
        ),
      ]),
      subtitleBuilder: (context, subtitle) => Container(
        padding: const EdgeInsets.all(4),
        child: Text(
          subtitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // optionsBuilder: (context, defaultOptions) async {
      //   await showDialog<void>(
      //     context: context,
      //     builder: (ctx) {
      //       return AlertDialog(
      //         content: Container(
      //           height: 300.0, // Change as per your requirement
      //           width: 300.0, // Change as per your requirement
      //           child: ListView.builder(
      //             shrinkWrap: true,
      //             itemCount: defaultOptions.length,
      //             itemBuilder: (_, i) => ActionChip(
      //               label: Text(defaultOptions[i].title),
      //               onPressed: () => defaultOptions[i].onTap!(),
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   );
      // },
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint('My option works!'),
            iconData: Icons.chat,
            title: 'My localized title',
          ),
          OptionItem(
            onTap: () => debugPrint('Another option working!'),
            iconData: Icons.chat,
            title: 'Another localized title',
          ),
        ];
      },
      optionsTranslation: OptionsTranslation(
        playbackSpeedButtonText: 'playbackSpeed'.tr,
        subtitlesButtonText: 'subtitles'.tr,
        cancelButtonText: 'cancel'.tr,
      ),
    );
  }
}
