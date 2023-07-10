import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/User_Files/Create_Tour_Files/Add_places_page.dart';
import 'package:roamify/User_Files/Create_Tour_Files/Create_tour_controller.dart';
import 'package:roamify/Utils/Widgets/CustomElevatedButton.dart';

import '../../Utils/Color_const.dart';
import '../../Utils/Input_Decoration.dart';

class Create_tour_page extends StatefulWidget {
  const Create_tour_page({super.key});

  @override
  State<Create_tour_page> createState() => _Create_tour_pageState();
}

class _Create_tour_pageState extends State<Create_tour_page> {
  Create_tour_controller tcontroller = Get.put(Create_tour_controller());
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: GetBuilder<Create_tour_controller>(
                    builder: (controller) {
                      return Form(
                          key: controller.tourformKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Create Tour",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 30,
                                        color: ColorConstant.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  40.height,
                                  // Text("Add Tour Thumbnail Image",
                                  //     style: TextStyle(
                                  //       fontFamily: 'Inter',
                                  //       fontSize: 30,
                                  //       color: ColorConstant.whiteA700,
                                  //       fontWeight: FontWeight.bold,
                                  //     )),
                                  InkWell(
                                    onTap: () {
                                      tcontroller.picksingleimage();
                                    },
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: ht * 0.3,
                                          width: wt * 0.9,
                                          child: Obx(
                                            () => tcontroller
                                                    .singleimageList.isNotEmpty
                                                ? Image.file(
                                                    tcontroller.singleimage!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    "assets/images/tourdemo.jpg",
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Positioned(
                                          top: ht * 0.04,
                                          left: wt * 0.1,
                                          child: Text(
                                            "Click Here to Add Thunmbnail",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 20,
                                              color: ColorConstant.whiteA700,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  40.height,
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.blueGray300,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Text("Tour Name",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 20,
                                              color: ColorConstant.whiteA700,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        AppTextField(
                                          controller:
                                              tcontroller.tourname_controller,
                                          focus: tcontroller.tournameFocusNode,
                                          nextFocus:
                                              tcontroller.tourlocationFocusNode,
                                          textStyle: primaryTextStyle(),
                                          textFieldType: TextFieldType.NAME,
                                          decoration: inputDecoration(
                                              context: context,
                                              labelText: "Tour name",
                                              hintText: "Enter Tour name"),
                                        ),
                                        8.height,
                                        Text(
                                          "Tour Location",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            color: ColorConstant.whiteA700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        AppTextField(
                                          controller: tcontroller
                                              .tourlocation_controller,
                                          focus:
                                              tcontroller.tourlocationFocusNode,
                                          nextFocus: tcontroller
                                              .tourdescriptionFocusNode,
                                          textStyle: primaryTextStyle(),
                                          textFieldType: TextFieldType.NAME,
                                          decoration: inputDecoration(
                                            context: context,
                                            labelText: "Tour location",
                                            hintText: "Enter Tour location",
                                          ),
                                        ),
                                        8.height,

                                        Text(
                                          "Tour Description",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            color: ColorConstant.whiteA700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        AppTextField(
                                          controller: tcontroller
                                              .tourdescription_controller,
                                          focus: tcontroller
                                              .tourdescriptionFocusNode,
                                          nextFocus:
                                              tcontroller.tourdaysFocusNode,
                                          maxLines: 10,
                                          minLines: 5,
                                          textStyle: primaryTextStyle(),
                                          textFieldType: TextFieldType.OTHER,
                                          decoration: inputDecoration(
                                            context: context,
                                            labelText: "Tour description",
                                            hintText: "Enter Tour description",
                                          ),
                                        ),
                                        8.height,
                                        Text(
                                          "Tour Days",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            color: ColorConstant.whiteA700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        AppTextField(
                                          controller:
                                              tcontroller.tourdays_controller,
                                          focus: tcontroller.tourdaysFocusNode,
                                          nextFocus:
                                              tcontroller.tourpriceFocusNode,
                                          textStyle: primaryTextStyle(),
                                          textFieldType: TextFieldType.NUMBER,
                                          decoration: inputDecoration(
                                            context: context,
                                            labelText: "Tour days",
                                            hintText: "Enter Tour days",
                                          ),
                                        ),
                                        8.height,

                                        Text(
                                          "Tour Price",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            color: ColorConstant.whiteA700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        AppTextField(
                                          controller:
                                              tcontroller.tourprice_controller,
                                          focus: tcontroller.tourpriceFocusNode,
                                          nextFocus: tcontroller
                                              .tourMaxPersonFocusNode,
                                          textStyle: primaryTextStyle(),
                                          textFieldType: TextFieldType.NUMBER,
                                          decoration: inputDecoration(
                                            context: context,
                                            labelText: "Tour price",
                                            hintText: "Enter Tour price",
                                          ),
                                        ),
                                        8.height,

                                        // Repeat the above pattern for other text fields...

                                        Text(
                                          "Tour Max Person",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            color: ColorConstant.whiteA700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        AppTextField(
                                          controller: tcontroller
                                              .tour_max_person_controller,
                                          focus: tcontroller
                                              .tourMaxPersonFocusNode,
                                          nextFocus: tcontroller
                                              .tourMinPersonFocusNode,
                                          textStyle: primaryTextStyle(),
                                          textFieldType: TextFieldType.NUMBER,
                                          decoration: inputDecoration(
                                            context: context,
                                            labelText: "Tour max person",
                                            hintText: "Enter Tour max person",
                                          ),
                                        ),
                                        8.height,
                                        Text(
                                          "Tour Min Person",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            color: ColorConstant.whiteA700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        AppTextField(
                                          controller: tcontroller
                                              .tour_min_person_controller,
                                          focus: tcontroller
                                              .tourMinPersonFocusNode,
                                          nextFocus:
                                              tcontroller.tourLastDateFocusNode,
                                          textStyle: primaryTextStyle(),
                                          textFieldType: TextFieldType.NUMBER,
                                          decoration: inputDecoration(
                                            context: context,
                                            labelText: "Tour min person",
                                            hintText: "Enter Tour min person",
                                          ),
                                        ),
                                        8.height,
                                        Text(
                                          "Tour booking Last Date",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            color: ColorConstant.whiteA700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        4.height,
                                        Text("${tcontroller.selectedDate}",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 14,
                                              color: ColorConstant.whiteA700,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      tcontroller.selectedDate,
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                ).then((pickedDate) {
                                                  if (pickedDate != null) {
                                                    setState(() {
                                                      tcontroller.selectedDate =
                                                          pickedDate;
                                                    });
                                                  }
                                                });
                                              },
                                              child: Text(
                                                  "${tcontroller.selectedDate.day}/${tcontroller.selectedDate.month}/${tcontroller.selectedDate.year}"),
                                            ),
                                            8.width,
                                            ElevatedButton(
                                              onPressed: () {
                                                showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ).then((pickedTime) {
                                                  if (pickedTime != null) {
                                                    setState(() {
                                                      tcontroller.selectedDate =
                                                          DateTime(
                                                              tcontroller
                                                                  .selectedDate
                                                                  .year,
                                                              tcontroller
                                                                  .selectedDate
                                                                  .month,
                                                              tcontroller
                                                                  .selectedDate
                                                                  .day,
                                                              pickedTime.hour,
                                                              pickedTime
                                                                  .minute);
                                                    });
                                                  }
                                                });
                                              },
                                              child: Text(
                                                  "${tcontroller.selectedDate.hour}:${tcontroller.selectedDate.minute}"),
                                            ),
                                          ],
                                        ),
                                        8.height,

                                        Text(
                                          "Tour Starting Date",
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            color: ColorConstant.whiteA700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        4.height,

                                        Text(
                                            "${tcontroller.tourstartselectedDate}",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 14,
                                              color: ColorConstant.whiteA700,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: tcontroller
                                                      .tourstartselectedDate,
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                ).then((pickedDate) {
                                                  if (pickedDate != null) {
                                                    setState(() {
                                                      tcontroller
                                                              .tourstartselectedDate =
                                                          pickedDate;
                                                    });
                                                  }
                                                });
                                              },
                                              child: Text(
                                                  "${tcontroller.tourstartselectedDate.day}/${tcontroller.tourstartselectedDate.month}/${tcontroller.tourstartselectedDate.year}"),
                                            ),
                                            8.width,
                                            ElevatedButton(
                                              onPressed: () {
                                                showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ).then((pickedTime) {
                                                  if (pickedTime != null) {
                                                    setState(() {
                                                      tcontroller
                                                              .tourstartselectedDate =
                                                          DateTime(
                                                              tcontroller
                                                                  .tourstartselectedDate
                                                                  .year,
                                                              tcontroller
                                                                  .tourstartselectedDate
                                                                  .month,
                                                              tcontroller
                                                                  .tourstartselectedDate
                                                                  .day,
                                                              pickedTime.hour,
                                                              pickedTime
                                                                  .minute);
                                                    });
                                                  }
                                                });
                                              },
                                              child: Text(
                                                  "${tcontroller.tourstartselectedDate.hour}:${tcontroller.tourstartselectedDate.minute}"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  15.height,
                                  CustomElevatedButton(
                                    height: ht * 0.07,
                                    width: wt,
                                    radius: 10,
                                    onPressed: () async {
                                      if (tcontroller.tourformKey.currentState!
                                          .validate()) {
                                        tcontroller.tourformKey.currentState!
                                            .save();

                                        Get.to(() => Add_place_page());
                                      }
                                    },
                                    child: Text("Next Step",
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 20,
                                          color: ColorConstant.whiteA700,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  )
                                ]),
                          ));
                    },
                  ),
                ),
              ),
            )));
  }
}
