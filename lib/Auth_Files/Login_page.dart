import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/Utils/Color_const.dart';
import 'package:roamify/Utils/Widgets/CustomElevatedButton.dart';

import '../Utils/Input_Decoration.dart';
import 'Auth_controller.dart';

class Loginpage extends GetWidget<AuthController> {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstant.darkbg,
          body: Container(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  40.height,
                  Text(
                      "Welcome Again \nLet's start an Amazing Journey \n with Roamify",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  7.height,

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: ColorConstant.whiteA700,
                                fontWeight: FontWeight.bold,
                              )),
                          4.height,
                          AppTextField(
                              controller: controller.emailController,
                              focus: controller.emailFocus,
                              nextFocus: controller.passwordFocus,
                              textStyle: primaryTextStyle(),
                              textFieldType: TextFieldType.EMAIL,
                              decoration: inputDecoration(
                                  context: context,
                                  labelText: "Email",
                                  hintText: "Enter your email")),
                          18.height,
                          Text("Password",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: ColorConstant.whiteA700,
                                fontWeight: FontWeight.bold,
                              )),
                          4.height,
                          AppTextField(
                            controller: controller.passwordController,
                            focus: controller.passwordFocus,
                            textStyle: primaryTextStyle(),
                            textFieldType: TextFieldType.PASSWORD,
                            decoration: inputDecoration(
                                context: context,
                                labelText: "Password",
                                hintText: "Enter password"),
                          ),
                          38.height,
                          Visibility(
                            visible: !controller.isLoading.value,
                            replacement: Center(
                              child: CircularProgressIndicator(
                                color: ColorConstant.whiteA700,
                              ),
                            ),
                            child: CustomElevatedButton(
                              height: ht * 0.07,
                              width: wt,
                              radius: 10,
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  FocusScope.of(context).unfocus();
                                  await controller.login();
                                }
                              },
                              child: Text("Login",
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
          ))),
    );
  }
}
