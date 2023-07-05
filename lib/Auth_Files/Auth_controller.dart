import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamify/Utils/Shpref_service.dart';

import '../API_Files/Api_Service.dart';
import '../API_Files/Api_urls.dart';
import '../API_Files/Token_manager.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  var isLoading = false.obs;
  RxInt AgeIndex = 0.obs;

  void changeIndex(int index) {
    AgeIndex.value = index;
    update();
  }

  Future<void> signup() async {
    isLoading(true);
    final user = {
      'name': nameController.text.toString().trim(),
      'email': emailController.text.toString().trim(),
      'password': passwordController.text.toString().trim(),
      'contactNumber': phoneController.text.toString().trim(),
      'city': cityController.text.toString().trim(),
      'country': countryController.text.toString().trim(),
      'pincode': pincodeController.text.toString().trim(),
    };

    print(user.toString());

    try {
      final response = await _apiService.authpost(ApiUrls.register_url, user);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        final tokenid = responseData['tockenid'];
        final jwtToken = responseData['tocken'];
        await TokenManager.saveTokenandid(jwtToken, tokenid);

        if (jwtToken != null && tokenid != null) {
          await TokenManager.saveTokenandid(jwtToken, tokenid);
          await Shpref_Service.saveauthstatus(true);
          isLoading(false);
          Get.snackbar("Welcome", "User created successfully",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 2));
          Get.offAllNamed('/rootpage');
        } else {
          print('JWT Token or Token ID is null');
        }
      } else if (response.statusCode == 400) {
        isLoading(false);
        Get.snackbar(
          "User already exists",
          "Please login to continue",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error: ${response.statusCode}');
        print('Error: ${response.data}');
      }
    } catch (error) {
      isLoading(false);
      print('Error: $error');
      Get.snackbar(
        "Network Problem",
        "Please check your internet connection",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> login() async {
    isLoading(true);
    final user = {
      'email': emailController.text.toString().trim(),
      'password': passwordController.text.toString().trim(),
    };

    print(user.toString());

    try {
      final response = await _apiService.authpost(ApiUrls.login_url, user);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Response: ${response.data}');
        Map<String, dynamic> responseData = response.data;
        final tokenid = responseData['tockenid'];
        final jwtToken = responseData['tocken'];

        if (jwtToken != null && tokenid != null) {
          isLoading(false);
          Get.snackbar("Welcome", "User created successfully",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 2));
          await TokenManager.saveTokenandid(jwtToken, tokenid);
          await Shpref_Service.saveauthstatus(true)
              .then((value) => Get.offAllNamed('/rootpage'));
        }
      } else if (response.statusCode == 500) {
        isLoading(false);
        Get.snackbar(
          "User Not exists",
          "Please First Register yourself to continue",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error: ${response.statusCode}');
        print('Error: ${response.data}');
      }
    } catch (error) {
      isLoading(false);
      print('Error: $error');
      Get.snackbar(
        "Network Problem",
        "Please check your internet connection",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
