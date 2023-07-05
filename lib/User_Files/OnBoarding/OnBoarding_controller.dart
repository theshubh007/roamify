import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class OnBoardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  List<String> lottieList = [
    'assets/lotties/tour1.json',
    'assets/lotties/taxi.json',
    'assets/lotties/tour2.json',
    
  ];
List<String> headerList = [
    'Welcome to Roamify',
    'Find all Tours',
    'Create tour and find group members', // Removed semicolon at the end
  ];

  List<String> descriptionList = [
    "Roamify is a platform where you can find all the tours and trips around you. You can also create your own tour and find group members for your tour.",
    "This is the second page of the onboarding screen",
    "Roamify is a platform where you can find all the tours and trips around you. You can also create your own tour and find group members for your tour.", // Removed semicolon at the end
  ];


late List<Future<LottieComposition>> lottieCompositions;

  @override
  void onInit() {
    super.onInit();
    lottieCompositions = lottieList.map((path) async {
      final data = await rootBundle.load(path);
      return await LottieComposition.fromByteData(data);
    }).toList();
  }


  Future<LottieComposition> getLottieComposition(int index) async {
    if (index >= 0 && index < lottieCompositions.length) {
      return lottieCompositions[index];
      ;
    }
    throw Exception("Invalid index");
  }

  void updateIndex() {
    currentIndex.value = currentIndex.value + 1;
    update();
  }
}
