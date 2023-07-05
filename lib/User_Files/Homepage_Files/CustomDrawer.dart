import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/Global_controllers/User_Controller.dart';
import 'package:roamify/Utils/Color_const.dart';

class CustomDrawer extends GetWidget<UserController> {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstant.darkbluebg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          InkWell(
            onTap: () {
              Get.toNamed("/userdatapage");
            },
            child: DrawerHeader(
              decoration: BoxDecoration(
                // color: ColorConstant.darkblueshade,
                color: ColorConstant.blueGray400,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        // margin: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/user_profile.jpg'))),
                        child: const Center(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstant.greenteal,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    controller.userDto.value.name,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: ColorConstant.whiteA700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    controller.userDto.value.email,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: ColorConstant.whiteA700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            tileColor: ColorConstant.darkblueshade,
            leading: Icon(Icons.home, color: ColorConstant.whiteA700),
            title:
                Text('Home', style: TextStyle(color: ColorConstant.whiteA700)),
            onTap: () {
              Get.toNamed("/rootpage");
            },
          ),
          4.height,
          ListTile(
            tileColor: ColorConstant.darkblueshade,
            leading:
                Icon(Icons.add_location_alt, color: ColorConstant.whiteA700),
            title: Text('Create Tour',
                style: TextStyle(color: ColorConstant.whiteA700)),
            onTap: () {
              Get.toNamed("/createtourpage");
            },
          ),
          4.height,
          ListTile(
            tileColor: ColorConstant.darkblueshade,
            leading: Icon(Icons.receipt_long, color: ColorConstant.whiteA700),
            title: Text('My Tours',
                style: TextStyle(color: ColorConstant.whiteA700)),
            onTap: () {
              Get.toNamed("/mybookings");
            },
          ),
          4.height,
          ListTile(
            tileColor: ColorConstant.darkblueshade,
            leading: Icon(Icons.logout, color: ColorConstant.whiteA700),
            title: Text('Logout',
                style: TextStyle(color: ColorConstant.whiteA700)),
            onTap: () async {
              await controller.logOut();
            },
          ),
        ],
      ),
    );
  }
}
