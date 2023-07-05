import 'package:get/get.dart';

import '../../Global_controllers/User_Controller.dart';
import 'Homepage_controller.dart';

class Homepage_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(() => HomepageController());
    Get.lazyPut<UserController>(() => UserController());

  }
}