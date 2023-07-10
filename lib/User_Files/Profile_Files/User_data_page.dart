import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/Utils/Color_const.dart';

import '../../Utils/Input_Decoration.dart';
import '../../Utils/Widgets/CustomElevatedButton.dart';
import 'User_datapage_controller.dart';

class User_Data_page extends GetWidget<User_datapage_Controller> {
  const User_Data_page({super.key});

  @override
  Widget build(BuildContext context) {
    double ht = Get.height;
    double wt = Get.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "My Data",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 120,
                height: 120,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/images/user_profile.jpg'))),
                child: const Center(),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => ListTile(
                  tileColor: ColorConstant.darkblueshade,
                  leading: const Icon(Icons.mail, color: Colors.white),
                  title: Text("Email",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(controller.userDto.value.email.toString(),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      10.height,

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              15.height,
                              Text("Name",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    color: ColorConstant.whiteA700,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: const Offset(
                                          0, 15), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: AppTextField(
                                    controller: controller.nameController,
                                    focus: controller.nameFocus,
                                    nextFocus: controller.phoneFocus,
                                    textStyle: primaryTextStyle(),
                                    textFieldType: TextFieldType.NAME,
                                    decoration: inputDecoration(
                                        context: context,
                                        labelText: "Name",
                                        hintText: "Enter Name")),
                              ),
                              15.height,
                              Text("Phone",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: ColorConstant.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: const Offset(
                                          0, 15), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: AppTextField(
                                  controller: controller.phoneController,
                                  focus: controller.phoneFocus,
                                  nextFocus: controller.cityFocus,
                                  textStyle: primaryTextStyle(),
                                  textFieldType: TextFieldType.PHONE,
                                  decoration: inputDecoration(
                                      context: context,
                                      labelText: "Phone",
                                      hintText: "Enter your phone number"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your phone number";
                                    } else if (value.length < 10 ||
                                        value.length > 10) {
                                      return "Please enter a valid phone number";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              15.height,
                              Text("City Name",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    color: ColorConstant.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: const Offset(
                                          0, 15), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: AppTextField(
                                  controller: controller.cityController,
                                  focus: controller.cityFocus,
                                  nextFocus: controller.countryFocus,
                                  textStyle: primaryTextStyle(),
                                  textFieldType: TextFieldType.NAME,
                                  decoration: inputDecoration(
                                      context: context,
                                      labelText: "City name name",
                                      hintText: "Enter City name"),
                                ),
                              ),
                              15.height,
                              Text("Country Name",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    color: ColorConstant.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: const Offset(
                                          0, 15), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: AppTextField(
                                  controller: controller.countryController,
                                  focus: controller.countryFocus,
                                  nextFocus: controller.pinFocus,
                                  textStyle: primaryTextStyle(),
                                  textFieldType: TextFieldType.NAME,
                                  decoration: inputDecoration(
                                      context: context,
                                      labelText: "Country name",
                                      hintText: "Enter Country name"),
                                ),
                              ),
                              14.height,
                              Text("Pincode",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    color: ColorConstant.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: const Offset(
                                          0, 15), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: AppTextField(
                                  controller: controller.pincodeController,
                                  focus: controller.pinFocus,
                                  textStyle: primaryTextStyle(),
                                  textFieldType: TextFieldType.NUMBER,
                                  decoration: inputDecoration(
                                      // color: ColorConstant.darkblueshade,
                                      context: context,
                                      labelText: "Enter your pincode",
                                      hintText: "Enter your pincode"),
                                ),
                              ),
                              15.height,
                              Center(
                                child: CustomElevatedButton(
                                  height: ht * 0.07,
                                  width: wt * 0.4,
                                  radius: 10,
                                  onPressed: () async {
                                    await controller.updateprofile();
                                  },
                                  child: Text("Update",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20,
                                        color: ColorConstant.whiteA700,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //buttons for next and back
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
