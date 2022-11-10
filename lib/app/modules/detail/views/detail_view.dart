import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'welcome'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            Obx(() => Text("count is ${controller.count.value}")),
            // buildChewiePlayer(),
            ElevatedButton(
              onPressed: controller.increment,
              child: const Text('increment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChewiePlayer() {
    return SizedBox(
      height: 350,
      width: Get.width,
      child: Center(
        child: controller.chewieController != null &&
                controller
                    .chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: controller.chewieController!)
            : Center(child: Text("loading".tr)),
      ),
    );
  }

  Widget buildBetterPlayer() {
    return SizedBox(
      height: 350,
      width: Get.width,
      child: Center(
        child: controller.betterPlayerController != null
            ? AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(
                    controller: controller.betterPlayerController!),
              )
            : Text('loading'.tr),
      ),
    );
  }
}
