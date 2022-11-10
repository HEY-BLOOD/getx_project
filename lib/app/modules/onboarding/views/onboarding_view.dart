import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_project/app/routes/app_pages.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get.find<OnboardingController>();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('OnboardingView'),
      //   centerTitle: true,
      // ),
      body: buildOnboardingBody(),
    );
  }

  Widget buildOnboardingBody() {
    return IntroductionScreen(
      onDone: () => Get.offAllNamed(Routes.HOME),
      // You can override onSkip callback
      onSkip: () => Get.offAllNamed(Routes.HOME),
      // skipOrBackFlex: 0,
      // nextFlex: 0,
      // you cannot set 'showBackButton' and 'showSkipButton' to true. Only one, or both false.)
      showSkipButton: true,
      // showBackButton: true,
      // rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      pages: [
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('assets/flutter.png'),
          // decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('assets/flutter.png'),
          // decoration: pageDecoration,
          footer: ElevatedButton(
            onPressed: () {
              // On button presed
            },
            child: const Text("Let's Go !"),
          ),
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('assets/flutter.png'),
          // decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: Lottie.asset(
            'assets/lottiefiles/114814-website-optimization.json',
            // height: 175,
          ),
          // decoration: pageDecoration,
        ),
      ],
    );
  }

  Widget _buildImage(String image) {
    return Image.asset(
      image,
      height: 175,
    );
  }
}
