import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamify/Global_controllers/User_Controller.dart';
import 'package:roamify/Utils/Color_const.dart';
import 'package:roamify/Utils/Widgets/CustomElevatedButton.dart';

class ProfilePage extends GetWidget<UserController> {
  ProfilePage({super.key});
  UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    double ht = Get.height;
    double wt = Get.width;
    return SafeArea(
        child: Scaffold(
            // backgroundColor: ColorConstant.grayblack,
            backgroundColor: ColorConstant.black,
            appBar: AppBar(
              backgroundColor: ColorConstant.black,
              elevation: 0,
              title: Text("Profile",
                  style: TextStyle(
                      color: ColorConstant.whiteA700,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: ht * 0.30,
                    child: Image(
                      image: const AssetImage(
                        "assets/images/roamifylogo.png",
                      ),
                      height: 25,
                      width: wt * 0.8,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: ht,
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteA700,
                          borderRadius: BorderRadius.circular(38),
                        ),
                      ),
                      Positioned(
                        top: ht * 0.05,
                        left: wt * 0.05,
                        child: Container(
                          height: ht * 0.2,
                          width: wt * 0.9,
                          decoration: BoxDecoration(
                            color: ColorConstant.grayblack,
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: ht * 0.05,
                              ),
                              Text(
                                userController.userDto.value.name,
                                style: TextStyle(
                                    color: ColorConstant.whiteA700,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                userController.userDto.value.email,
                                style: TextStyle(
                                    color: ColorConstant.whiteA700,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/userdatapage");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: ColorConstant.blueGray40087,
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(38),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: wt * 0.05,
                                      vertical: ht * 0.01),
                                  child: Text(
                                    "Complete your profile ->",
                                    style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: ht * 0.3,
                        left: wt * 0.05,
                        child: Container(
                          // height: ht * 0.2,
                          width: wt * 0.9,
                          padding: EdgeInsets.symmetric(
                              horizontal: wt * 0.08, vertical: ht * 0.03),
                          decoration: BoxDecoration(
                            // color: ColorConstant.blueGray400,
                            // color: ColorConstant.blueGray50,
                            color: ColorConstant.graylight,
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Features",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("1. Create your own tour",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("2. Join a tour",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("3. Scan QR code",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("4. View your tours",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("5. View your profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("6. Share your profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("7. View your profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("8. View your profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("9. View your profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ht * 0.01,
                              ),
                              const Text("10. View your profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: ht * 0.9,
                        left: wt * 0.05,
                        right: wt * 0.05,
                        child: CustomElevatedButton(
                          height: ht * 0.07,
                          width: wt,
                          color: Colors.red,
                          radius: 10,
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ht * 0.05,
                  ),
                ],
              ),
            )));
  }
}
