import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamify/Global_controllers/User_Controller.dart';
import 'package:roamify/Models/Tourdto.dart';

import '../../API_Files/Api_Service.dart';
import '../../API_Files/Api_urls.dart';
import '../../Utils/Shpref_service.dart';

class User_booking_controller extends GetxController {
  final ApiService _apiService = ApiService();
  UserController userController = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<Tourdto>> get_booked_tour() async {
    try {
      String uid = userController.userDto.value.Uid;
      print(uid);
      print(uid);

      final data = {"uid": uid};
      final response = await _apiService.post(ApiUrls.getbooked_tour_url, data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          print(responseData['data']);
          final tourList = (responseData['data'] as List)
              .map((json) => Tourdto.fromJson(json))
              .toList();
          print('Tour List: $tourList');
          return tourList;
        } else {
          throw Exception('API Error: ${responseData['message']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      // if (error is DioError) {
      //   if (error.response?.statusCode == 403) {
      //     Get.snackbar(
      //       "Session expired",
      //       "Login again",
      //       snackPosition: SnackPosition.TOP,
      //       backgroundColor: Colors.red,
      //       colorText: Colors.white,
      //     );
      //     await Shpref_Service.saveauthstatus(false);
      //     await Shpref_Service.removealldata();
      //     Get.offAllNamed("/login");
      //   }
      // }
      rethrow; // Return an empty list or handle the error case as per your requirement
    }
  }

  Future<List<Tourdto>> get_created_tour() async {
    try {
      String uid = userController.userDto.value.Uid;
      print(uid);
      print(uid);

      final data = {"uid": uid};
      final response =
          await _apiService.post(ApiUrls.getcreated_tour_url, data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          print(responseData['data']);
          final tourList = (responseData['data'] as List)
              .map((json) => Tourdto.fromJson(json))
              .toList();
          print('Tour List: $tourList');
          return tourList;
        } else {
          throw Exception('API Error: ${responseData['message']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      // if (error is DioError) {
      //   if (error.response?.statusCode == 403) {
      //     Get.snackbar(
      //       "Session expired",
      //       "Login again",
      //       snackPosition: SnackPosition.TOP,
      //       backgroundColor: Colors.red,
      //       colorText: Colors.white,
      //     );
      //     await Shpref_Service.saveauthstatus(false);
      //     await Shpref_Service.removealldata();
      //     Get.offAllNamed("/login");
      //   }
      // }
      rethrow; // Return an empty list or handle the error case as per your requirement
    }
  }

 
}
