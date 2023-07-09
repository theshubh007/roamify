import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:roamify/User_Files/OnBoarding/OnBoarding_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Utils/Color_const.dart';
import '../../Utils/Widgets/CustomElevatedButton.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  OnBoardingController controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.darkbg,
            body: GetBuilder<OnBoardingController>(builder: (controller) {
              return Padding(
                padding: EdgeInsets.all(0.02 * ht),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    18.height,

                    Container(
                      height: 300,
                      width: wt,
                      color: Colors.white,
                      child: FutureBuilder<LottieComposition>(
                        future: controller.getLottieComposition(
                            controller.currentIndex.value),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            final lottieProvider =
                                LottieCompositionProvider(snapshot.data!);
                            return LottieBuilder(
                              lottie: lottieProvider,
                              animate: true,
                              repeat: false,
                              reverse: false,
                              onLoaded: (composition) {
                                print(
                                    'Lottie ${controller.currentIndex} is loaded');
                              },
                              frameBuilder: (context, child, composition) {
                                return AnimatedOpacity(
                                  opacity: composition != null ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: child,
                                );
                              },
                              fit: BoxFit.cover,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),

                    30.height,
                    //button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: controller.currentIndex.value == 0
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text('1')),
                            ),
                            10.width,
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: controller.currentIndex.value == 1
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text('2')),
                            ),
                            10.width,
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: controller.currentIndex.value == 2
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text('3')),
                            ),
                          ],
                        ),
                      ],
                    ),
                    20.height,
                    Text(
                      textAlign: TextAlign.left,
                      controller.headerList[controller.currentIndex.value],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ht * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    25.height,
                    Text(
                      textAlign: TextAlign.left,
                      controller.descriptionList[controller.currentIndex.value],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ht * 0.02,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    // 20.height,

                    //button
                    const Spacer(),

                    CustomElevatedButton(
                      height: ht * 0.07,
                      width: wt,
                      radius: 10,
                      color: Colors.blue,
                      onPressed: () {
                        if (controller.currentIndex.value == 2) {
                          //write code to run circular progress indicator for 2 seconds
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          Timer(const Duration(seconds: 1), () {
                            // Close the progress indicator dialog
                            Navigator.of(context, rootNavigator: true).pop();

                            Get.offAllNamed('/signup');
                          });
                        } else {
                          controller.updateIndex();
                        }
                      },
                      child: Text(
                        controller.currentIndex.value == 2
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                   

                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        10.width,
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/login');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            })));
  }
}

class LottieCompositionProvider extends LottieProvider {
  final LottieComposition composition;

  LottieCompositionProvider(this.composition);

  @override
  Future<LottieComposition> load() async {
    return composition;
  }
}
