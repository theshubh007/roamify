import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/Global_controllers/User_Controller.dart';
import 'package:roamify/User_Files/Homepage_Files/CustomDrawer.dart';
import 'package:roamify/Utils/Color_const.dart';

import '../../Models/Tourdto.dart';
import '../../Utils/Widgets/TourRowCardTile.dart';
import '../TourDetail_Files/Tour_Detail_page.dart';
import 'Homepage_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomepageController controller = Get.put(HomepageController());
  TextEditingController searchcontroller = TextEditingController();

  UserController usercontroller = Get.find<UserController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(const AssetImage("assets/images/tourdemo.jpg"), context);
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: ColorConstant.black,
            drawer: const CustomDrawer(),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      CustomAppbar(scaffoldKey: _scaffoldKey),
                      18.height,

                      FutureBuilder(
                        future: usercontroller.fetchUserDto(),
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
                            return Obx(
                              () => Text(
                                'Welcome, ${usercontroller.userDto.value.name}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                        },
                      ),

                      18.height,
                      //search bar
                      Searchbar(),
                      18.height,
                      Obx(
                        () => controller.resultList.isNotEmpty &&
                                searchcontroller.text.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.resultList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Tourdto currdto =
                                      controller.resultList[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => Tour_Details(),
                                        arguments: {
                                          "admin": false,
                                          "tourdto": currdto,
                                          "booked": false,
                                        },
                                      );
                                    },
                                    child: TourRowCardTile(
                                      tourname: currdto.tourName,
                                      location: currdto.location,
                                      days: currdto.days,
                                      tourimage: currdto.tourProfileImage,
                                      price: currdto.chargePerPerson.toString(),
                                    ),
                                  );
                                })
                            : Column(
                                children: [
                                  Popular_Tour_header(),
                                  18.height,
                                  SizedBox(
                                      height: ht * 0.3,
                                      child: FutureBuilder<List<Tourdto>>(
                                        future:
                                            controller.get_explore_tourList(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<Tourdto>>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return const Text('No data found',
                                                style: TextStyle(
                                                    color: Colors.white));
                                          } else {
                                            if (snapshot.data!.isEmpty) {
                                              return const Center(
                                                  child: Text(
                                                      "No tours available"));
                                            }
                                            final tourList = snapshot.data;
                                            return SizedBox(
                                              height: ht * 0.3,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: tourList!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                          () => Tour_Details(),
                                                          arguments: {
                                                            "admin": false,
                                                            "tourdto":
                                                                tourList[index],
                                                            "booked": false,
                                                          },
                                                        );
                                                      },
                                                      child: TourCard(
                                                        tourname:
                                                            tourList[index]
                                                                .tourName,
                                                        location:
                                                            tourList[index]
                                                                .location,
                                                        days: tourList[index]
                                                            .days,
                                                        tourimage: tourList[
                                                                index]
                                                            .tourProfileImage,
                                                      ),
                                                    );
                                                  }),
                                            );
                                          }
                                        },
                                      )),
                                  18.height,
                                  Container(
                                    // height: ht * 0.15,

                                    padding: const EdgeInsets.only(
                                        top: 19,
                                        left: 19,
                                        right: 19,
                                        bottom: 19),
                                    width: wt,
                                    color: ColorConstant.blue,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Want to Create Your Tour?",
                                          style: TextStyle(
                                              fontSize: ht * 0.04,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        4.height,
                                        Text(
                                          "Tell Us Which kind of places do you want to cover and create custom tour and enjoy trip with family and friends",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ht * 0.02),
                                        )
                                      ],
                                    ),
                                  ),
                                  18.height,
                                  Explore_Tour_Header(),
                                  10.height,
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FutureBuilder<List<Tourdto>>(
                                          future:
                                              controller.get_explore_tourList(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<List<Tourdto>>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              return const Text('No data found',
                                                  style: TextStyle(
                                                      color: Colors.white));
                                            } else {
                                              final tourList = snapshot.data;

                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: tourList!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    Tourdto currdto =
                                                        tourList[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                          () => Tour_Details(),
                                                          arguments: {
                                                            "admin": false,
                                                            "tourdto": currdto,
                                                            "booked": false,
                                                          },
                                                        );
                                                      },
                                                      child: TourRowCardTile(
                                                        tourname:
                                                            currdto.tourName,
                                                        location:
                                                            currdto.location,
                                                        days: currdto.days,
                                                        tourimage: currdto
                                                            .tourProfileImage,
                                                        price: currdto
                                                            .chargePerPerson
                                                            .toString(),
                                                      ),
                                                    );
                                                  });
                                            }
                                          }))
                                ],
                              ),
                      ),
                    ],
                  )),
            )));
  }

  Row Explore_Tour_Header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Explore Amazing Trips',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            // Handle notifications
          },
          child: Text(
            'View All',
            style: TextStyle(
                color: ColorConstant.greenteal,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],

      // 18.height,
    );
  }

  Row Popular_Tour_header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Popular Tours',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            // Handle notifications
          },
          child: Text(
            'View All',
            style: TextStyle(
                color: ColorConstant.greenteal,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],

      // 18.height,
    );
  }

  Widget Searchbar() {
    return ValueListenableBuilder(
      valueListenable: searchcontroller,
      builder: (BuildContext context, dynamic value, Widget? child) {
        final searchText = searchcontroller.text;
        controller.searchTourPackages(searchText);
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ColorConstant.graydarkshade,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: searchcontroller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: ColorConstant.greenteal,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  searchcontroller.clear();
                  controller.resultList.clear();
                },
                icon: Icon(
                  Icons.clear,
                  color: ColorConstant.greenteal,
                ),
              ),
              hintText: "Search place you're looking for",
              hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        );
      },
    );
    // return Container(
    //   padding: const EdgeInsets.all(4),
    //   decoration: BoxDecoration(
    //       // color: ColorConstant.blueGray300,
    //       // color: ColorConstant.gray500,
    //       color: ColorConstant.graydarkshade,
    //       borderRadius: BorderRadius.circular(15)),
    //   child: TextField(
    //     controller: searchcontroller,
    //     onChanged: (val) {
    //       setState(() {
    //         controller.searchTourPackages(val);
    //       });
    //     },
    //     style: const TextStyle(color: Colors.white),
    //     decoration: InputDecoration(
    //         border: InputBorder.none,
    //         prefixIcon: Icon(
    //           Icons.search,
    //           color: ColorConstant.greenteal,
    //         ),
    //         suffixIcon: IconButton(
    //           onPressed: () {
    //             searchcontroller.clear();
    //             setState(() {
    //               controller.searchTourPackages("");
    //             });
    //           },
    //           icon: Icon(
    //             Icons.clear,
    //             color: ColorConstant.greenteal,
    //           ),
    //         ),
    //         hintText: "Search place you're looking for",
    //         hintStyle: const TextStyle(color: Colors.white, fontSize: 15)),
    //   ),
    // );
  }
}

class TourCard extends StatelessWidget {
  String tourname;
  String location;
  int days;
  String? tourimage;
  TourCard(
      {super.key,
      required this.tourname,
      required this.location,
      required this.days,
      this.tourimage});

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    ImageProvider? imageProvider;

    if (tourimage != null) {
      imageBytes = base64Decode(tourimage!);
      imageProvider = MemoryImage(imageBytes);
    }

    return Container(
      height: 272,
      width: 222,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: ColorConstant.gray600,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 18,
            offset: const Offset(0, 18), // changes position of shadow
          ),
        ],
        image: (tourimage != null && tourimage!.isNotEmpty)
            ? DecorationImage(
                image: imageProvider!,
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage("assets/images/tourdemo.jpg"),
                fit: BoxFit.cover,
              ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.greenteal,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$days days',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        tourname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        // IconButton(
        //   onPressed: () {
        //     // Handle notifications
        //   },
        //   icon: const Icon(
        //     Icons.notifications,
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }
}
