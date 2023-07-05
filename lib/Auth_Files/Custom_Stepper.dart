import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/Utils/Color_const.dart';
import 'package:roamify/Utils/Widgets/Selection_tile.dart';

import '../Utils/Input_Decoration.dart';
import 'Auth_controller.dart';

class Stepperdemo extends StatefulWidget {
  const Stepperdemo({super.key});

  @override
  State<Stepperdemo> createState() => _StepperdemoState();
}

class _StepperdemoState extends State<Stepperdemo> {
  int activeStep = 0;
  PageController pagecontroller = PageController(initialPage: 0);
  final _firstformKey = GlobalKey<FormState>();
  final _secondformKey = GlobalKey<FormState>();
  final _thirdformKey = GlobalKey<FormState>();
  bool fstate = false;
  bool sstate = false;

  final AuthController authController = Get.put(AuthController());


  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode countryFocus = FocusNode();
  FocusNode pinFocus = FocusNode();

  void setpage(int index) {
    setState(() {
      activeStep = index;
      pagecontroller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameFocus.addListener(() {
      if (!nameFocus.hasFocus) {
        setState(() {});
      }
    });
    activeStep = 0;
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstant.darkbg,
          body: Column(
            children: [
              Container(
                alignment: const Alignment(0, 0.3),
                child: EasyStepper(
                  activeStep: activeStep,
                  lineLength: 80,
                  stepShape: StepShape.rRectangle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 10, vertical: 10),
                  stepRadius: 28,
                  // finishedStepBorderColor: Colors.deepOrange,
                  finishedStepBorderColor: Colors.blue.withOpacity(0.3),
                  finishedStepTextColor: Colors.blue.withOpacity(0.3),
                  finishedStepBackgroundColor: Colors.blue.withOpacity(0.3),
                  activeStepIconColor: Colors.deepOrange,
                  showLoadingAnimation: true,
                  activeStepBorderColor: Colors.teal,
                  enableStepTapping: false,
                  //line color
                  // activeStepBackgroundColor: Colors.teal,
                  steps: [
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 0 ? 1 : 0.3,
                          child: Lottie.asset(
                            "assets/lotties/tour1.json",
                          ),
                        ),
                      ),
                      customTitle: const Text(
                        'Personal Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 1 ? 1 : 0.3,
                          // child: Image.asset('assets/images/doctor.JPG'),
                          child: Lottie.asset(
                            "assets/lotties/taxi.json",
                          ),
                        ),
                      ),
                      customTitle: const Text(
                        'Tour Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 2 ? 1 : 0.3,
                          // child: Image.asset('assets/images/doctor.JPG'),
                          child: Lottie.asset(
                            "assets/lotties/taxi.json",
                          ),
                        ),
                      ),
                      customTitle: const Text(
                        'Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
              ),

              //pageview

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pagecontroller,
                    onPageChanged: (index) =>
                        setState(() => activeStep = index),
                    children: [
                      SingleChildScrollView(child: Form1details(context)),
                      SingleChildScrollView(child: Form2details(context)),
                      SingleChildScrollView(child: Form3details(context))
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Form Form1details(BuildContext context) {
    return Form(
      key: _firstformKey,
      child: Column(
        children: [
          Text("Register YourSelf \nFor an Amazing Journey",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 25,
                color: ColorConstant.whiteA700,
                fontWeight: FontWeight.bold,
              )),
          7.height,

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                      controller: authController.nameController,
                      focus: nameFocus,
                      nextFocus: emailFocus,
                      textStyle: primaryTextStyle(),
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                          context: context,
                          labelText: "Name",
                          hintText: "Enter Name")),
                  14.height,
                  Text("Email",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                      controller: authController.emailController,
                      focus: emailFocus,
                      nextFocus: passwordFocus,
                      textStyle: primaryTextStyle(),
                      textFieldType: TextFieldType.EMAIL,
                      decoration: inputDecoration(
                          context: context,
                          labelText: "Email",
                          hintText: "Enter your email")),
                  14.height,
                  Text("Password",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                    controller: authController.passwordController,
                    focus: passwordFocus,
                    nextFocus: phoneFocus,
                    textStyle: primaryTextStyle(),
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: inputDecoration(
                        context: context,
                        labelText: "Password",
                        hintText: "Enter password"),
                  ),
                  14.height,
                  Text("Phone",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: ColorConstant.whiteA700,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                    controller: authController.phoneController,
                    focus: phoneFocus,
                    // nextFocus: passwordFocus,
                    textStyle: primaryTextStyle(),
                    textFieldType: TextFieldType.PHONE,
                    decoration: inputDecoration(
                        context: context,
                        labelText: "Phone",
                        hintText: "Enter your phone number"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your phone number";
                      } else if (value.length < 10 || value.length > 10) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),

          //buttons for next and back
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: AppButton(
                    color: Colors.blue,
                    onTap: () {
                      if (_firstformKey.currentState!.validate()) {
                      setState(() {
                        fstate = true;
                      });
                      setpage(1);
                      }
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form Form2details(BuildContext context) {
    return Form(
      key: _secondformKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("City Name",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                    controller: authController.cityController,
                    focus: cityFocus,
                    nextFocus: countryFocus,
                    textStyle: primaryTextStyle(),
                    textFieldType: TextFieldType.NAME,
                    decoration: inputDecoration(
                        context: context,
                        labelText: "City name name",
                        hintText: "Enter City name"),
                  ),
                  14.height,
                  Text("Country Name",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                    controller: authController.countryController,
                    focus: countryFocus,
                    nextFocus: pinFocus,
                    textStyle: primaryTextStyle(),
                    textFieldType: TextFieldType.NAME,
                    decoration: inputDecoration(
                        context: context,
                        labelText: "Country name",
                        hintText: "Enter Country name"),
                  ),
                  14.height,
                  Text("Pincode",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  AppTextField(
                    controller: authController.pincodeController,
                    focus: pinFocus,
                    textStyle: primaryTextStyle(),
                    textFieldType: TextFieldType.NUMBER,
                    decoration: inputDecoration(
                        context: context,
                        labelText: "Enter your pincode",
                        hintText: "Enter your pincode"),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: AppButton(
                    color: Colors.blue,
                    onTap: () {
                      setpage(0);
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: AppButton(
                    color: Colors.blue,
                    onTap: () {
                      if (_secondformKey.currentState!.validate()) {
                      setpage(2);
                      }
                      // setpage(2);
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form Form3details(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Form(
      key: _thirdformKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select your Age",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 27,
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.bold,
                      )),
                  10.height,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        authController.changeIndex(0);
                      });
                    },
                    child: UserTypeTile(
                        data: "age<18",
                        isSelected: authController.AgeIndex == 0,
                        width: wt,
                        height: ht * 0.1,
                        radius: 10),
                  ),
                  5.height,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        authController.changeIndex(1);
                      });
                    },
                    child: UserTypeTile(
                        data: "18<age <45",
                        isSelected: authController.AgeIndex == 1,
                        width: wt,
                        height: ht * 0.1,
                        radius: 10),
                  ),
                  5.height,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        authController.changeIndex(2);
                      });
                    },
                    child: UserTypeTile(
                        data: "45<age",
                        isSelected: authController.AgeIndex == 2,
                        width: wt,
                        height: ht * 0.1,
                        radius: 10),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: AppButton(
                    color: Colors.blue,
                    onTap: () {
                      setpage(1);
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Visibility(
                  visible: authController.isLoading == false,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: AppButton(
                      color: Colors.blue,
                      onTap: () async {
                        if (_thirdformKey.currentState!.validate()) {
                          authController.isLoading(true);
                          //wait for 2 seconds to simulate loading of data
                          // await Future.delayed(const Duration(seconds: 2));
                          await authController.signup();
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
