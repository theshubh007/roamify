import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamify/API_Files/Api_Service.dart';
import 'package:roamify/Models/Tourdto.dart';
import 'package:roamify/Utils/Shpref_service.dart';
import '../../API_Files/Api_urls.dart';
import '../../API_Files/Token_manager.dart';
import '../../Models/Userdto.dart';

class HomepageController extends GetxController {
  Rx<String> token = ''.obs;
  Rx<String> tokenid = ''.obs;
  final ApiService _apiService = ApiService();
  RxInt totalTourResponse = 0.obs;
  RxList<Tourdto> tourList = <Tourdto>[].obs;
  Tourdto? selectedtour;
  @override
  Future<void> onInit() async {
    super.onInit();
    print('HomepageController init entered');
    await getuserdata();
  }

  Future<void> getuserdata() async {
    try {
      print('getuserdata entered');
      print('getuserdata entered');
      print('getuserdata entered');
      String refreshtokenid = await TokenManager.getTokenid();
      final data = {"refreshtoken": refreshtokenid};
      final response = await _apiService.post(ApiUrls.getuserdata_url, data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['success']) {
          Userdto userDto = Userdto.fromJson(responseData['data']);
          await Shpref_Service.saveUserDto(userDto);
          print('User: ${userDto.toString()}');
        } else {
          print('Error: Failed to retrieve user data');
        }
      }
    } catch (error) {
      print('Error: $error');
      if (error is DioError) {
        print('Error: ${error.response?.statusCode}');
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 400) {
          Get.snackbar(
            "Session expired",
            "Login again",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          Get.offAllNamed("/login");
        }
      }
    }
  }

  RxList<Tourdto> cachetourList = <Tourdto>[].obs;
  Future<List<Tourdto>> get_explore_tourList() async {
    try {
      if (cachetourList.isNotEmpty) {
        return cachetourList;
      }
      final response = await _apiService.post(ApiUrls.explore_tour_url, "");
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          totalTourResponse.value = responseData['totalResponse'];

          final tourList = (responseData['tourList'] as List)
              .map((json) => Tourdto.fromJson(json))
              .toList();
          print('Tour List: $tourList');
          cachetourList.value = tourList;
          return tourList;
        } else {
          throw Exception('API Error: ${responseData['message']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      if (error is DioError) {
        if (error.response?.statusCode == 403) {
          Get.snackbar(
            "Session expired",
            "Login again",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          await Shpref_Service.saveauthstatus(false);
          await Shpref_Service.removealldata();
          Get.offAllNamed("/login");
        }
      }

      rethrow; // Return an empty list or handle the error case as per your requirement
    }
  }

  RxBool searching = false.obs;
  RxList<Tourdto> resultList = <Tourdto>[].obs;
  Future<void> searchTourPackages(String query) async {
    try {
      if (query.isEmpty) {
        searching.value = false;
        resultList.value = [];
        return;
      }
      searching.value = true;
      final response = await _apiService
          .post(ApiUrls.search_tour_url, {"searchinput": query});
      if (response.statusCode == 200) {
        // Parse the response JSON
        final responseData = response.data;
        List<Tourdto> tourPackages = (responseData['data'] as List)
            .map((json) => Tourdto.fromJson(json))
            .toList();
        // Use the retrieved tourPackages in your UI
        resultList.value = tourPackages;
      } else {
        // Handle the API error
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error occurred during API request: $e');
    }
  }
}
