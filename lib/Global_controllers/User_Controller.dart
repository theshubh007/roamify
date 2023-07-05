import 'package:get/get.dart';

import '../Models/Userdto.dart';
import '../Utils/Shpref_service.dart';

class UserController extends GetxController {
  final userDto = Userdto(
    Uid: '',
    name: '',
    email: '',
    contactNumber: '',
    city: '',
    country: '',
    pincode: '',
  ).obs;

  @override
  Future<void> onInit() async {
    print("user controller init");
    super.onInit();
    await fetchUserDto();
    // Fetch the Userdto data during initialization
  }

  Future<void> fetchUserDto() async {
    try {
      print("fetching user details");
      final storedUserDto = await Shpref_Service.getUserDto();
      if (storedUserDto != null) {
        userDto.value = storedUserDto;
      }
    } catch (e) {
      // Handle any errors that occur during data retrieval
      print('Error fetching user data: $e');
    }
  }

  Future<void> logOut() async {
    try {
      await Shpref_Service.saveauthstatus(false);
      await Shpref_Service.removealldata();
      Get.offAllNamed('/onboarding');
    } catch (e) {
      print('Error logging out user: $e');
    }
  }
}
