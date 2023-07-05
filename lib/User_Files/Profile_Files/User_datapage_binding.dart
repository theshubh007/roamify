import 'package:get/get.dart';

import '../../Global_controllers/User_Controller.dart';
import 'User_datapage_controller.dart';

class User_Datapage_binding extends Bindings {
  @override
  void dependencies() {
   
    Get.lazyPut<User_datapage_Controller>(() => User_datapage_Controller());
  }
}