import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roamify/Auth_Files/Login_page.dart';
import 'package:roamify/Global_controllers/User_Controller.dart';
import 'package:roamify/User_Files/Create_Tour_Files/Create_tour_page.dart';
import 'package:roamify/User_Files/Homepage_Files/Homepage.dart';
import 'package:roamify/User_Files/Homepage_Files/Homepage_binding.dart';
import 'package:roamify/User_Files/OnBoarding/OnBoarding_page.dart';
import 'package:roamify/User_Files/Profile_Files/User_datapage_binding.dart';
import 'package:roamify/User_Files/Root_page.dart';
import 'package:roamify/User_Files/TourDetail_Files/Tour_Member_List_Page.dart';
import 'package:roamify/User_Files/User_Bookings_Files/User_Bookings_Page.dart';
import 'package:roamify/Utils/Shpref_service.dart';

import 'API_Files/Token_manager.dart';
import 'Auth_Files/Auth_binding.dart';
import 'Auth_Files/SignUp_page.dart';
import 'User_Files/OnBoarding/OnBoardingbinding.dart';
import 'User_Files/Profile_Files/User_data_page.dart';
import 'User_Files/TourDetail_Files/Tour_Detail_page.dart';
import 'Utils/MultiLanguage_support/Locale_string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await TokenManager.init();
  // AuthControllerBinding().dependencies();
  runApp(const MyApp());
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Future<String> getinitialRoute() async {
//     bool authstatus = await Shpref_Service.getauthstatus();
//     if (!authstatus) {
//       return "/login";
//     } else {
//       return "/homepage";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       translations: LocaleString(),
//       locale: const Locale('en', 'US'),

//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: getinitialRoute(),
//       // initialBinding: HomeBinding(),
//       // initialBinding: BindingsBuilder(() {
//       //   // like this!
//       //   Get.put(Controller());
//       // }),
//       // home: Signup_page(),
//       getPages: AppRoutes.appRoutes,
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String> getinitialRoute() async {
    bool authstatus = await Shpref_Service.getauthstatus();
    if (!authstatus) {
      return "/onboarding";
      // return "/signup";
    } else {
      return "/rootpage";
    }
  }

  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getinitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Future is still loading
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error occurred while fetching initial route
          return Text('Error: ${snapshot.error}');
        } else {
          // Successfully obtained initial route
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocaleString(),
           
            locale: const Locale('en', 'US'),
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Poppins'
            ),
            home: Container(), // Replace Container() with your home widget
            initialRoute: snapshot.data!,
            getPages: AppRoutes.appRoutes,
          );
        }
      },
    );
  }
}

class AppRoutes {
  static List<GetPage<dynamic>> appRoutes = [
    GetPage(
        name: "/onboarding",
        page: () => const OnBoardingPage(),
        binding: OnBoardingbinding()),
    GetPage(
        name: "/signup",
        page: () => const Stepperdemo(),
        binding: AuthControllerBinding()),
    GetPage(
        name: "/login",
        page: () => const Loginpage(),
        binding: AuthControllerBinding()),
    GetPage(
      name: "/rootpage",
      page: () => const RootPage(),
    ),
    GetPage(
        name: "/homepage",
        page: () => const HomePage(),
        binding: Homepage_binding()),
    GetPage(
      name: "/createtourpage",
      page: () => const Create_tour_page(),
    ),
    GetPage(
      name: "/mybookings",
      page: () => const User_Bookings_Page(),
    ),
    GetPage(
        name: "/userdatapage",
        page: () => const User_Data_page(),
        binding: User_Datapage_binding()),
    GetPage(
      name: "/tourdetails",
      page: () => Tour_Details(),
    ),
    GetPage(
      name: "/memberlist",
      page: () => Tour_Member_List_Page(tid: Get.arguments as String),
    )
  ];
}
