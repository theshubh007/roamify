import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:roamify/Global_controllers/User_Controller.dart';

import '../../API_Files/Api_Service.dart';
import '../../API_Files/Api_urls.dart';
import '../../Models/Placedto.dart';

class Create_tour_controller extends GetxController {
  UserController userController = Get.find();
  final tourformKey = GlobalKey<FormState>();
  RxBool isloading = false.obs;
  TextEditingController tourname_controller = TextEditingController();
  TextEditingController tourlocation_controller = TextEditingController();
  TextEditingController tourdescription_controller = TextEditingController();
  TextEditingController tourdays_controller = TextEditingController();
  TextEditingController tourprice_controller = TextEditingController();
  TextEditingController tour_max_person_controller = TextEditingController();
  TextEditingController tour_approved_controller = TextEditingController();
  TextEditingController tour_min_person_controller = TextEditingController();
  TextEditingController tour_last_date_controller = TextEditingController();
  TextEditingController tourimage_controller = TextEditingController();

  TextEditingController city_name_controller = TextEditingController();
  TextEditingController city_videolink_controller = TextEditingController();
  TextEditingController city_image_controller = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime tourstartselectedDate = DateTime.now();

  FocusNode tournameFocusNode = FocusNode();
  FocusNode tourlocationFocusNode = FocusNode();
  FocusNode tourdescriptionFocusNode = FocusNode();
  FocusNode tourdaysFocusNode = FocusNode();
  FocusNode tourpriceFocusNode = FocusNode();
  FocusNode tourMaxPersonFocusNode = FocusNode();
  FocusNode tourApprovedFocusNode = FocusNode();
  FocusNode tourMinPersonFocusNode = FocusNode();
  FocusNode tourLastDateFocusNode = FocusNode();
  FocusNode tourImageFocusNode = FocusNode();

  final RxList<File> singleimageList = RxList<File>();
  // RxList<String> singlebase64 = RxList<String>();
  File? singleimage;
  String singleimagebase64 = "";
  Future<void> picksingleimage() async {
    try {
      List<Asset> images = await MultipleImagesPicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: [],
        materialOptions: const MaterialOptions(
          actionBarColor: "#FF4081",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      if (images.isNotEmpty) {
        List<File> files = [];
        // List<String> base64List = [];
        for (Asset image in images) {
          final data = await image.getByteData();
          final file =
              File('${(await getTemporaryDirectory()).path}/${image.name}');
          await file.writeAsBytes(data.buffer.asUint8List());
          files.add(file);
          singleimage = file;

          singleimagebase64 = base64Encode(file.readAsBytesSync());
          // base64List.add(base64Image);
        }

        // singleimageList.value = files;
        // base64ImagesList.value = base64List;
      }
    } catch (e) {
      print(e);
    }
  }

///////////////////////////////////////////
///////////////////////////////////////////
  FocusNode cityNameFocusNode = FocusNode();
  FocusNode cityVideoLinkFocusNode = FocusNode();
  FocusNode cityImageFocusNode = FocusNode();
  TextEditingController placename_controller1 = TextEditingController();
  TextEditingController placevideo_controller1 =
      TextEditingController(text: "Not Available");
  FocusNode placenamenode = FocusNode();
  FocusNode placevideonode = FocusNode();
  // List<TextEditingController> places_name_controller = [];
  // List<TextEditingController> places_video_controller = [];
  List<Placedto> place_list = [];
  var place_formakey = GlobalKey<FormState>();
  RxInt totalplaces = 0.obs;

  void update_total_places(int val) {
    totalplaces.value += val;
    update();
  }

  Future<void> addplace(Placedto place) async {
    place_list.add(place);
    placename_controller1.clear();
    placevideo_controller1.text = "Not Available";
    update();
  }

  ///////////////////////////
  ///
  ///
  final RxList<File> imageFiles = RxList<File>();
  RxList<String> base64ImagesList = RxList<String>();
  // List<File> get imageFiles => _imageFiles.toList();
  Future<void> pickImages() async {
    try {
      List<Asset> images = await MultipleImagesPicker.pickImages(
        maxImages: totalplaces.value,
        enableCamera: true,
        selectedAssets: [],
        materialOptions: const MaterialOptions(
          actionBarColor: "#FF4081",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      if (images.isNotEmpty) {
        List<File> files = [];
        List<String> base64List = [];
        for (Asset image in images) {
          final data = await image.getByteData();
          final file =
              File('${(await getTemporaryDirectory()).path}/${image.name}');
          await file.writeAsBytes(data.buffer.asUint8List());
          files.add(file);

          String base64Image = base64Encode(file.readAsBytesSync());
          base64List.add(base64Image);
        }

        imageFiles.value = files;
        base64ImagesList.value = base64List;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> create_final_Tour_schema() async {
    if (place_list.length != imageFiles.length) {
      Get.snackbar("Error", "Please add all places images");
      return;
    }
    List<String> compressedBase64List = [];
    for (int i = 0; i < place_list.length; i++) {
      String base64Image = base64ImagesList[i];
      String compressedBase64 = await compressAndEncodeImage(base64Image);
      compressedBase64List.add(compressedBase64);
    }
    for (int i = 0; i < place_list.length; i++) {
      place_list[i].place_image = compressedBase64List[i];
    }
    String singleprofilebase64image = singleimagebase64;

    String formattedlastDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(selectedDate);
    String formattedstartDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(tourstartselectedDate);
    String compressprofile = "";
    if (singleprofilebase64image != "") {
      compressprofile = await compressAndEncodeImage(singleprofilebase64image);
    }

    var tourinfo = {
      "tourName": tourname_controller.text.trim(),
      "location": tourlocation_controller.text.trim(),
      "description": tourdescription_controller.text.trim(),
      "days": tourdays_controller.text.trim(),
      "chargePerPerson": tourprice_controller.text.trim(),
      "maxPerson": tour_max_person_controller.text.trim(),
      "approved": false,
      "minPerson": tour_min_person_controller.text.trim(),
      "dueDateTime": formattedlastDate,
      "tourstartdate": formattedstartDate,
      "tourProfileImage": compressprofile.toString(),
    };
    String uid = userController.userDto.value.Uid.toString();
    print(uid);
    print(uid);
    print(uid);
    var tourFinalSchema = {
      "userId": uid,
      "packageInfo": tourinfo,
      'cityInfoList': place_list.map((city) => city.toJson()).toList(),
    };
    return tourFinalSchema;
  }

  Future<void> Create_tour_package(BuildContext context) async {
    final ApiService apiService = ApiService();
    try {
      var tourschema = await create_final_Tour_schema();
      print(tourschema);
      final response =
          await apiService.post(ApiUrls.create_tour_url, tourschema);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        Get.snackbar("Done!!!", "Tour Package Created Successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.toNamed("/rootpage");
        Navigator.of(context, rootNavigator: true).pop();
      } else {
        Get.snackbar(
          "Network Problem",
          "Please check your internet connection",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Navigator.of(context, rootNavigator: true).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> compressAndEncodeImage(String base64Image) async {
    // Decode the base64 image into bytes
    List<int> imageBytes = base64Decode(base64Image);

    // Get a temporary directory to save the compressed image
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    Uint8List imageUint8List = Uint8List.fromList(imageBytes);

    // Compress the image using flutter_image_compress
    Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
      imageUint8List,
      minHeight: 1920,
      minWidth: 1080,
      quality: 80,
    );

    String compressedImagePath = '$tempPath/compressed_image.jpg';
    File(compressedImagePath).writeAsBytesSync(compressedBytes);

    // Encode the compressed image as base64
    String compressedBase64 =
        base64Encode(File(compressedImagePath).readAsBytesSync());

    // Delete the temporary compressed image file
    File(compressedImagePath).deleteSync();

    return compressedBase64;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
