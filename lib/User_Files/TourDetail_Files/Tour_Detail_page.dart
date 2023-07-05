import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/Models/Memberdto.dart';
import 'package:roamify/Models/Placedto.dart';
import 'package:roamify/Models/Tourdto.dart';
import 'package:roamify/User_Files/TourDetail_Files/Tour_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/Color_const.dart';
import '../../Utils/Widgets/CustomElevatedButton.dart';

class Tour_Details extends GetWidget<Tour_detail_controller> {
  Tour_Details({Key? key}) : super(key: key);

  Tour_detail_controller tdcontroller = Get.put(Tour_detail_controller());
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments;
    Tourdto tourdto = arguments["tourdto"] as Tourdto;
    bool admin = arguments["admin"] as bool;
    bool booked = arguments['booked'] as bool;
    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;
    Uint8List? imageBytes;
    ImageProvider? imageProvider;

    imageBytes = base64Decode(tourdto.tourProfileImage);
    imageProvider = MemoryImage(imageBytes);
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.black,
      appBar: AppBar(
        backgroundColor: ColorConstant.black,
        title: Text(
          tourdto.tourName.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 272,
                  width: wt,
                  // margin: const EdgeInsets.only(right: 15, left: 15),
                  decoration: BoxDecoration(
                    color: ColorConstant.gray600,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 18,
                        offset:
                            const Offset(0, 18), // changes position of shadow
                      ),
                    ],
                    image: (tourdto.tourProfileImage.isNotEmpty)
                        ? DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage("assets/images/tourdemo.jpg"),
                            fit: BoxFit.cover,
                          ),
                  )),
              30.height,
              Detail_Row_Widget(
                icon: Icons.explore,
                data: "Tour_NamE : ${tourdto.tourName}",
              ),
              3.height,
              Detail_Row_Widget(
                icon: Icons.location_on,
                data: "Tour_Location : ${tourdto.location}",
              ),
              3.height,
              //write for tour info

              Detail_Row_Widget(
                icon: Icons.info,
                data: "Tour Info",
              ),
              3.height,

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    textAlign: TextAlign.left,
                    tourdto.description.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
              Detail_Row_Widget(
                icon: Icons.date_range,
                data: "Tour_Days : ${tourdto.days}",
              ),
              3.height,
              Detail_Row_Widget(
                icon: Icons.payment,
                data: "Charge/person : ${tourdto.chargePerPerson}",
              ),
              3.height,
              Detail_Row_Widget(
                icon: Icons.event,
                data: "Booking ends : ${tourdto.dueDateTime}",
              ),
              3.height,

              Detail_Row_Widget(
                icon: Icons.tour,
                data: "Tour Begins : ${tourdto.tourstartdate}",
              ),
              3.height,

              30.height,
              Container(
                decoration: BoxDecoration(
                  color: ColorConstant.graydarkshade,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 18,
                      offset: const Offset(0, 18), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      "Places",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    FutureBuilder<List<Placedto>>(
                        future: tdcontroller
                            .get_all_cities_of_Tour(tourdto.tId.toString()),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Text('No data found',
                                style: TextStyle(color: Colors.white));
                          } else {
                            final cityList = snapshot.data;
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cityList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Placedto currdto = cityList[index];
                                  return ListTile(
                                    title: Text(currdto.place_name.toString(),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  );
                                });
                          }
                        }),
                  ],
                ),
              ),

              ////////////////////////////////////////////////
              ///images
              30.height,
              Container(
                width: wt,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ColorConstant.graydarkshade,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 18,
                      offset: const Offset(0, 18), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Images",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    15.height,
                    FutureBuilder<List<ImageProvider>>(
                        future: tdcontroller
                            .get_all_images_of_Tour(tourdto.tId.toString()),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Text('No data found',
                                style: TextStyle(color: Colors.white));
                          } else {
                            return Wrap(
                              spacing: 8.0,
                              runSpacing: 5.0,
                              children: List.generate(
                                snapshot.data.length,
                                (index) => Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.gray600,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 18,
                                        offset: const Offset(0,
                                            18), // changes position of shadow
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: snapshot.data[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),

              ////////////////////////////////////////////////////
              ///
              ///
              ///
              ///
              30.height,
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ColorConstant.graydarkshade,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 18,
                      offset: const Offset(0, 18), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      "Tour Organizer",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    15.height,
                    FutureBuilder<Memberdto>(
                        future: tdcontroller.get_Agent(tourdto.tId.toString()),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Text('No data found',
                                style: TextStyle(color: Colors.white));
                          } else {
                            Memberdto agent = snapshot.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name : ${agent.name}",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                5.height,
                                Text("Email : ${agent.email}",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                5.height,
                                Text("Contact : ${agent.contactNumber}",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                5.height,
                                InkWell(
                                  onTap: () async {
                                    var number = agent.contactNumber;
                                    String url =
                                        "https://wa.me/91$number?text=Hi from Roamify";
                                    var encodeduri = Uri.parse(url);
                                    if (!await launchUrl(
                                      encodeduri,
                                      mode: LaunchMode.externalApplication,
                                    )) {
                                      throw 'Could not launch $encodeduri';
                                    }
                                  },
                                  child: Container(
                                    width: wt * 0.4,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        // backgroundBlendMode: Colors.green,
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // const Icon(
                                        //   Icons.phone,
                                        //   color: Colors.white,
                                        // ),
                                        Image(
                                          image: AssetImage(
                                              "assets/images/whatsapp.png"),
                                          height: 20,
                                          width: 20,
                                        ),
                                        Text("Contact Now",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                                3.height
                              ],
                            );
                          }
                        }),
                  ],
                ),
              ),

              30.height,
              InkWell(
                onTap: () {
                  Get.toNamed("/memberlist", arguments: tourdto.tId.toString());
                },
                child: Container(
                  height: ht * 0.07,
                  decoration: BoxDecoration(
                    color: ColorConstant.gray600,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 18,
                        offset:
                            const Offset(0, 18), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text("See All the Members ->",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),

              30.height,

              Visibility(
                visible: !admin && !booked,
                child: CustomElevatedButton(
                  height: ht * 0.07,
                  width: wt,
                  radius: 10,
                  onPressed: () async {
                    tdcontroller.book_Tour(tourdto.tId.toString());
                  },
                  child: Text("Book Now",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: admin,
                  child: Visibility(
                    visible: !tdcontroller.isloading.value,
                    replacement: const CircularProgressIndicator(),
                    child: CustomElevatedButton(
                      height: ht * 0.07,
                      width: wt,
                      radius: 10,
                      color: Colors.red,
                      onPressed: () async {
                        tdcontroller.isloading.value = true;
                        tdcontroller.delete_Tour(tourdto.tId.toString());
                      },
                      child: Text(
                        "Delete Tour",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          color: ColorConstant.whiteA700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              Visibility(
                visible: booked,
                child: CustomElevatedButton(
                  height: ht * 0.07,
                  width: wt,
                  radius: 10,
                  onPressed: () async {},
                  child: Text("Booked",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),

              25.height,
            ],
          ),
        ),
      ),
    ));
  }
}

class Detail_Row_Widget extends StatelessWidget {
  Detail_Row_Widget({
    super.key,
    required this.data,
    required this.icon,
  });

  final String data;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(data, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
