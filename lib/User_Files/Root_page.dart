import 'package:flutter/material.dart';
import 'package:roamify/User_Files/Create_Tour_Files/Create_tour_page.dart';
import 'package:roamify/User_Files/Homepage_Files/Homepage.dart';
import 'package:roamify/User_Files/Profile_Files/Profile_page.dart';
import 'package:roamify/User_Files/User_Bookings_Files/User_Bookings_Page.dart';
import 'package:roamify/Utils/Color_const.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List pages = [
    const HomePage(),
    const Create_tour_page(),
    // Add_place_page(),
    const User_Bookings_Page(),
    ProfilePage()
  ];

  int currindex = 0;
  void ontap(int index) {
    setState(() {
      currindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currindex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorConstant.darkbg,
          selectedItemColor: ColorConstant.greenteal,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: ontap,
          currentIndex: currindex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_location_alt), label: "Create tour"),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long), label: "My Tours"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.qr_code_scanner), label: "My Tours"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "My Profile"),
          ]),
    );
  }
}
