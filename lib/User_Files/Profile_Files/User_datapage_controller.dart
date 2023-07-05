import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamify/API_Files/Token_manager.dart';

import '../../API_Files/Api_Service.dart';
import '../../API_Files/Api_urls.dart';
import '../../Models/Userdto.dart';
import '../../Utils/Shpref_service.dart';

class User_datapage_Controller extends GetxController {
  final ApiService _apiService = ApiService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
   FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode countryFocus = FocusNode();
  FocusNode pinFocus = FocusNode();

final userDto = Userdto(
    Uid: '',
    name: '',
    email: '',
    contactNumber: '',
    city: '',
    country: '',
    pincode: '',
  ).obs;
  
   Future<void> fetchUserDto() async {
    try {
      final storedUserDto = await Shpref_Service.getUserDto();
      if (storedUserDto != null) {
        userDto.value = storedUserDto;
        emailController.text = userDto.value.email;
        nameController.text = userDto.value.name;
        phoneController.text = userDto.value.contactNumber;
        cityController.text = userDto.value.city;
        countryController.text = userDto.value.country;
        pincodeController.text = userDto.value.pincode;

      }
    } catch (e) {
      // Handle any errors that occur during data retrieval
      print('Error fetching user data: $e');
    }
  }



   Future<void> updateprofile() async {
    
    final user = {
      'email': emailController.text.toString().trim(),
      'name': nameController.text.toString().trim(),
      'contactNumber': phoneController.text.toString().trim(),
      'city': cityController.text.toString().trim(),
      'country': countryController.text.toString().trim(),
      'pincode': pincodeController.text.toString().trim(),
    };

    print(user.toString());

    try {
      final response = await _apiService.put(ApiUrls.updateuserdata_url, user);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
       
            Userdto userDto = Userdto.fromJson(responseData['data']);
        await Shpref_Service.saveUserDto(userDto);
        print('User: ${userDto.toString()}');


          Get.snackbar("Done!!", "Your data updated successfully",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 2));
          Get.offAllNamed('/rootpage');
        
        
      } else if (response.statusCode == 400) {
       
        Get.snackbar(
          "Unable to Update",
          "Please try again later",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error: ${response.statusCode}');
        print('Error: ${response.data}');
      }
    } catch (error) {
      
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


  @override
  void onInit() {
    super.onInit();
    fetchUserDto(); // Fetch the Userdto data during initialization
  }

  @override
  void onClose() {
    super.onClose();
  }
}
