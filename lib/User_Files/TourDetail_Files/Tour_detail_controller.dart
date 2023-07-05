import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamify/Global_controllers/User_Controller.dart';
import 'package:roamify/Models/Placedto.dart';

import '../../API_Files/Api_Service.dart';
import '../../API_Files/Api_urls.dart';
import '../../Models/Memberdto.dart';
import '../../Utils/Shpref_service.dart';

class Tour_detail_controller extends GetxController {
  RxBool isloading = false.obs;
  final ApiService _apiService = ApiService();
  RxList<String> placeimages = <String>[].obs;
  UserController userController = Get.find<UserController>();

  ///////get cities
  ///
  ///
  Future<List<Placedto>> get_all_cities_of_Tour(String tid) async {
    try {
      print(tid);
      print(tid);

      final data = {"tid": tid};
      final response =
          await _apiService.post(ApiUrls.get_tour_cities_url, data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          print(responseData['data']);
          final cityList = (responseData['data'] as List)
              .map((json) => Placedto.fromJson(json))
              .toList();
          print('City List: $cityList');

          return cityList;
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

  ///get images
  ///
  Future<List<ImageProvider>> get_all_images_of_Tour(String tid) async {
    try {
      print(tid);
      print(tid);

      final data = {"tid": tid};
      final response =
          await _apiService.post(ApiUrls.get_tour_images_url, data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          print(responseData['imageList']);
          // final cityList = (responseData['data'] as List)
          //     .map((json) => Placedto.fromJson(json))
          //     .toList();
          // print('City List: $cityList');
          List<String> imageList = responseData['imageList'].cast<String>();
          List<ImageProvider> imageProviderList = [];
          for (var element in imageList) {
            var imageBytes = base64Decode(element);
            var imageProvider = MemoryImage(imageBytes);
            imageProviderList.add(imageProvider);
          }

          return imageProviderList;
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

  // /book tour
  Future<void> book_Tour(String tid) async {
    try {
      String uid = userController.userDto.value.Uid;
      // print(uid);
      // print(uid);
      print("uid:$uid");
      print("tid:$tid");
      // print(tid);
      // print(tid);

      final data = {"tid": tid, "uid": uid};
      final response = await _apiService.post(ApiUrls.book_tour_url, data);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          Get.snackbar(
            "Success",
            "Tour Booked",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed("/rootpage");
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
        } else {
          Get.snackbar(
            "Notice:",
            "You have already booked this tour",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          Get.offAllNamed("/rootpage");
        }
      }
      rethrow; // Return an empty list or handle the error case as per your requirement
    }
  }

  Future<List<Memberdto>> get_Member_List(String tid) async {
    try {
      final data = {"tid": tid};
      final response = await _apiService.post(ApiUrls.tour_members_url, data);
      print(response.statusCode);
      print(response.statusCode);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          final memberList = (responseData['data'] as List)
              .map((json) => Memberdto.fromJson(json))
              .toList();

          print('Member List: $memberList');

          return memberList;
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

  ///get agent
  Future<Memberdto> get_Agent(String tid) async {
    try {
      final data = {"tid": tid};
      final response = await _apiService.post(ApiUrls.tour_agent_url, data);
      print(response.statusCode);
      print(response.statusCode);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          Memberdto Agentdetails = Memberdto.fromJson(responseData['data']);

          return Agentdetails;
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

  //delete tour
  Future<void> delete_Tour(String tid) async {
    try {
      String uid = userController.userDto.value.Uid;
      final data = {"tid": tid, "uid": uid};
      final response = await _apiService.post(ApiUrls.delete_tour_url, data);
      print(response.statusCode);
      print(response.statusCode);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['success'] == true) {
          Get.snackbar("Done!!!", "Tour Package Deleted Successfully",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white);
              isloading.value=false;

          Get.offAllNamed("/rootpage");
        } else {
          isloading.value=false;
          throw Exception('API Error: ${responseData['message']}');

        }
      } else {
        isloading.value=false;
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      isloading.value=false;
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
}
