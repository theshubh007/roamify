import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/Models/Placedto.dart';
import 'package:roamify/User_Files/Create_Tour_Files/Create_tour_controller.dart';

import '../../Utils/Color_const.dart';
import '../../Utils/Input_Decoration.dart';
import '../../Utils/Widgets/CustomElevatedButton.dart';

class Add_place_page extends GetWidget<Create_tour_controller> {
  Add_place_page({super.key});

  Create_tour_controller tcontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkbg,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white)),
                        Obx(
                          () => Text(
                            "Add Places \nTotal Places:${tcontroller.totalplaces.value}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              tcontroller.Create_tour_package();
                            },
                            icon: const Icon(Icons.check, color: Colors.white)),
                      ],
                    ),
                  ),
                  15.height,
                  Obx(() => Column(children: [
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tcontroller.place_list.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        tcontroller
                                            .place_list[index].place_name!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          tcontroller.place_list
                                              .removeAt(index);
                                          tcontroller.update_total_places(-1);
                                        },
                                        icon: const Icon(Icons.delete,
                                            color: Colors.white)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        78.height,
                        CustomElevatedButton(
                            height: ht * 0.07,
                            width: wt,
                            radius: 10,
                            onPressed: () async {
                              _showInputDialog(context);
                            },
                            child: tcontroller.totalplaces.value == 0
                                ? Text("+ Click here to add place",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      color: ColorConstant.whiteA700,
                                      fontWeight: FontWeight.bold,
                                    ))
                                : Text(
                                    "+ Add More Place",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      color: ColorConstant.whiteA700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                        26.height,
                        const Text(
                          "Add Images",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        tcontroller.imageFiles.isEmpty
                            ? Wrap(
                                spacing: 8.0,
                                runSpacing: 5.0,
                                children: List.generate(
                                  tcontroller.totalplaces.value,
                                  (index) => GestureDetector(
                                    onTap: () async {
                                      print("tapped");
                                      print("tapped");
                                      await tcontroller.pickImages();
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(Icons.add_a_photo),
                                    ),
                                  ),
                                ),
                              )
                            : Wrap(
                                spacing: 8.0,
                                runSpacing: 5.0,
                                children: List.generate(
                                  tcontroller.imageFiles.length,
                                  (index) => Stack(
                                    children: [
                                      Image.file(
                                        tcontroller.imageFiles[index],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: -3,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            tcontroller.imageFiles
                                                .removeAt(index);
                                            tcontroller.base64ImagesList
                                                .removeAt(index);
                                          },
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: ColorConstant.blueGray300,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ])),
                  18.height,
                  Obx(() {
                    return Visibility(
                      visible: !tcontroller.isloading.value,
                      replacement: const CircularProgressIndicator(),
                      child: CustomElevatedButton(
                        height: ht * 0.07,
                        width: wt,
                        radius: 10,
                        onPressed: () async {
                          if (tcontroller.place_list.length !=
                              tcontroller.base64ImagesList.length) {
                            tcontroller.imageFiles.clear();
                            tcontroller.base64ImagesList.clear();
                            Get.snackbar("Not valid", "Please add all images");
                            return;
                          }
                          tcontroller.isloading.value = true;
                          await tcontroller.Create_tour_package().then((value) {
                            tcontroller.isloading.value = false;
                            Get.toNamed("/rootpage");
                          });
                        },
                        child: Text("Finalize the Tour",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              color: ColorConstant.whiteA700,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    );
                  }),

                  // Visibility(
                  //   visible: tcontroller.isloading.value,
                  //   child: CustomElevatedButton(
                  //     height: ht * 0.07,
                  //     width: wt,
                  //     radius: 10,
                  //     onPressed: () async {},
                  //     child: const CircularProgressIndicator(),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Enter Text'),
          content: Expanded(
            child: Form(
              key: tcontroller.place_formakey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Place Name",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                    controller: tcontroller.placename_controller1,
                    focus: tcontroller.placenamenode,
                    nextFocus: tcontroller.placevideonode,
                    textStyle: primaryTextStyle(),
                    textFieldType: TextFieldType.NAME,
                    decoration: inputDecoration(
                        context: context,
                        labelText: "Place name",
                        hintText: "Enter Tour name"),
                  ),
                  8.height,
                  Text("Place Videos Link",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                    controller: tcontroller.placevideo_controller1,
                    focus: tcontroller.placevideonode,
                    textStyle: primaryTextStyle(),
                    textFieldType: TextFieldType.NAME,
                    decoration: inputDecoration(
                      context: context,
                      labelText: "Place video",
                      hintText: "Enter Place video",
                    ),
                  ),
                  8.height,
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (tcontroller.place_formakey.currentState!.validate()) {
                  String enteredText = tcontroller.placename_controller1.text;
                  Placedto newplace = Placedto(
                    place_name: tcontroller.placename_controller1.text,
                    place_video: tcontroller.placevideo_controller1.text,
                  );
                  await tcontroller
                      .addplace(newplace)
                      .then((value) => {tcontroller.update_total_places(1)});
                  print('Entered Text: $enteredText');
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
