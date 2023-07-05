import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Tour_detail_controller.dart';

class Tour_Member_List_Page extends GetWidget<Tour_detail_controller> {
  String tid;
  Tour_Member_List_Page({required this.tid, super.key});

  Tour_detail_controller tdcontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Tour group Member List'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<Tour_detail_controller>(
            builder: (controller) {
              return FutureBuilder(
                future: controller.get_Member_List(tid),
                builder: (context, snapshot) {
                  if (snapshot == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something Went Wrong'));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    var snap = snapshot.data;
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snap!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/user_profile.jpg'),
                              ),
                              title: Text(snap[index].name.toString(),
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(snap[index].email.toString(),
                                  style: const TextStyle(color: Colors.white)),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
