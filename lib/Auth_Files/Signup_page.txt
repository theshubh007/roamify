import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamify/Auth_Files/Auth_controller.dart';

class Signup_page extends GetWidget<AuthController> {
  Signup_page({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup Page'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GetBuilder<AuthController>(
                    builder: (controller) {
                      return Column(
                        children: [
                          TextFormField(
                            controller: controller.nameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: controller.passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: controller.phoneController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your contact number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: controller.cityController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your city',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: controller.countryController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your country',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: controller.pincodeController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your pincode',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.signup();
                              // if (formKey.currentState!.validate()) {
                              // }
                            },
                            child: const Text('Submit'),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/login');
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
