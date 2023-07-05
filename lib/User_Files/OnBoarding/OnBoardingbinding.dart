

import 'package:get/get.dart';

import 'OnBoarding_controller.dart';

class OnBoardingbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }
}