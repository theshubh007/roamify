import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamify/User_Files/User_Bookings_Files/User_booking_controller.dart';
import 'package:roamify/Utils/Color_const.dart';

import '../../Models/Tourdto.dart';
import '../../Utils/Widgets/TourCardTileAdmin.dart';
import '../../Utils/Widgets/TourRowCardTile.dart';
import '../TourDetail_Files/Tour_Detail_page.dart';

class User_Bookings_Page extends StatefulWidget {
  const User_Bookings_Page({super.key});

  @override
  State<User_Bookings_Page> createState() => _User_Bookings_PageState();
}

class _User_Bookings_PageState extends State<User_Bookings_Page>
    with TickerProviderStateMixin {
  late TabController _tabController;

  User_booking_controller user_booking_controller = User_booking_controller();
  final List<Tab> _tabs = [
    const Tab(text: 'My Bookings'),
    const Tab(text: 'Created Tours'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      appBar: AppBar(
        backgroundColor: ColorConstant.black,
        // automaticallyImplyLeading: false,
        title: const Text("User_Bookings_Page"),
      ),
      body: DefaultTabController(
        length: _tabs.length,
        child: Column(
          children: [
            Container(
              color: Colors.black, // Set the background color of TabBar
              child: TabBar(
                labelColor: Colors.white,
                tabs: _tabs,
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                      child: FutureBuilder(
                          future: user_booking_controller.get_booked_tour(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Text('No data found',
                                  style: TextStyle(color: Colors.white));
                            } else {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text("No tours available",
                                        style: TextStyle(color: Colors.white)));
                              }
                              final tourList = snapshot.data;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: tourList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Tourdto currdto = tourList[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => Tour_Details(),
                                          arguments: {
                                            "admin": false,
                                            "tourdto": tourList[index],
                                            "booked": true,
                                          },
                                        );
                                      },
                                      child: TourRowCardTile(
                                        tourname: currdto.tourName,
                                        location: currdto.location,
                                        days: currdto.days,
                                        tourimage: currdto.tourProfileImage,
                                        price:
                                            currdto.chargePerPerson.toString(),
                                      ),
                                    );
                                  });
                            }
                          })),
                  Container(
                      child: FutureBuilder(
                          future: user_booking_controller.get_created_tour(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Text('No data found',
                                  style: TextStyle(color: Colors.white));
                            } else {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text("No tours available",
                                        style: TextStyle(color: Colors.white)));
                              }
                              final tourList = snapshot.data;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: tourList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Tourdto currdto = tourList[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => Tour_Details(),
                                          arguments: {
                                            "admin": true,
                                            "tourdto": tourList[index],
                                            "booked": false,
                                          },
                                        );
                                      },
                                      child: TourRowCardTileAdmin(
                                        tourname: currdto.tourName,
                                        location: currdto.location,
                                        days: currdto.days,
                                        tourimage: currdto.tourProfileImage,
                                        price:
                                            currdto.chargePerPerson.toString(),
                                      ),
                                    );
                                  });
                            }
                          }))
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
