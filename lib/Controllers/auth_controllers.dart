import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:political/untils/export_file.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'dart:io';

class AuthController extends GetxController {
  final apiService = Get.put(ApiService());
  // ProfileController userprofilecontroller = Get.put(ProfileController());
  ///political login
  var userEmail = ''.obs;
  List employeesList = [
    // {"email": "nursery@utthishtha.com", "password": "Utthishtha@123"},
    // {"email": "soapsart@utthishtha.com", "password": "Utthishtha@123"},
    {"email": "ram123", "password": "ram123"},
    // {"email": "skillart@utthishtha.com", "password": "Utthishtha@123"}
  ];

  var userSignInLoading = false.obs;
  var isValidCredential = false.obs;
  void checkEmployee(Map credintials) {
    userSignInLoading(true);
    isValidCredential(false);
    for (int i = 0; i < employeesList.length; i++) {
      if (employeesList[i]["email"] == credintials["email"] &&
          employeesList[i]["password"] == credintials["password"]) {
        isValidCredential(true);
      }
    }

    if (isValidCredential == true) {
      Fluttertoast.showToast(
        msg: "Login Succesfully",
      );
      UserSimplePreferences.setLoginStatus(loginStatus: true);
      UserSimplePreferences.setToken(token: credintials["email"]);
      // UserSimplePreferences.getToken()
      Get.toNamed(kDashboardScreen);
      print("object");
    } else {
      Fluttertoast.showToast(
        msg: "Invalid Credentials",
      );
    }

    userSignInLoading(false);
  }

  ///
  ////////////////////////////////////////////////
  var counter = 0.obs;
  late TextEditingController textController;

  @override
  void onInit() {
    super.onInit();

    // Initialize the TextEditingController
    textController = TextEditingController(text: counter.value.toString());

    // Update the text field whenever the counter changes
    counter.listen((value) {
      textController.text = value.toString();
    });
  }

  void increment() {
    counter.value++;
  }

  void decrement() {
    if (counter.value > 0) {
      counter.value--;
    }
  }

  void setCounter(String value) {
    final int? parsedValue = int.tryParse(value);
    if (parsedValue != null && parsedValue >= 0) {
      counter.value = parsedValue;
    }
  }
  ///////////////////////////////////////////////////////

  TextEditingController UserEmailSignInController = TextEditingController();
  TextEditingController UserEmailPasswordController = TextEditingController();

  //
  TextEditingController autoPostMessageController = TextEditingController();
  TextEditingController autoPostHeadingController = TextEditingController();
  TextEditingController signUpCouponController = TextEditingController();
  ////////Coupons Api
  var signUpCouponLoading = false.obs;
  var isCouponApplied = false.obs;
  var signUpCoupondata = {}.obs;
  Future<void> SignUpCoupon(Map payload) async {
    signUpCouponLoading(true);

    try {
      //
      var response = await apiService.postRequestSignUpCouponsFormData(
          endpoint: "check-coupon-code-api/", payload: payload);

      //    Map data = jsonDecode(response);
      Map data = jsonDecode(response);
      print(data);

      if (data["message"] == "Coupon code is applied successfully") {
        signUpCoupondata.value = data["data"];
        isCouponApplied.value = true;
        Fluttertoast.showToast(
          msg: data["message"],
        );

        debugPrint("object");
      } else {
        Fluttertoast.showToast(
          msg: data["message"],
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      signUpCouponLoading(false);
    }
  }
  ////////

  Future<void> userSignIn(Map payload) async {
    userSignInLoading(true);

    try {
      //
      var response = await apiService.postRequestSignInFormData(
          endpoint: "login-user-api-simple/", payload: payload);

      //    Map data = jsonDecode(response);
      Map data = jsonDecode(response);
      print(data);
      if (data["status"] == "success") {
        await UserSimplePreferences.setLoginStatus(loginStatus: true);

        await UserSimplePreferences.setToken(
            token: data["data"]["session_token"].toString());
        await UserSimplePreferences.setUserDetails(data["data"] ?? {});

        // Fluttertoast.showToast(
        //   msg: data["message"],
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: KDarkPink_twg,
        //   textColor: Kwhite,
        //   fontSize: 16.0,
        // );

        // // Get.toNamed(kNavigation);
        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  UserSimplePreferences.setLoginStatus(loginStatus: true);
        //  UserSimplePreferences.setToken(token: credintials["email"]);
        // UserSimplePreferences.getToken()
        Get.toNamed(kDashboardScreen);
        print("object");

        print("object");
      } else if (data["status"] == "error") {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        Fluttertoast.showToast(
          msg: data["message"],
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      userSignInLoading(false);
    }
  }

//   Future<void> userSignIn(Map payload) async {
//     userSignInLoading(true);

//     try {
//       //
//       var response = await apiService.postRequestSignInFormData(
//           endpoint: "https://twgpost.in/login-user-api-simple/",
//           payload: payload);
// // https://twgpost.in/login-user-api-simple/
//       //    Map data = jsonDecode(response);
//       Map data = jsonDecode(response);
//       print(data);
//       if (data["status"] == "success") {
//         await UserSimplePreferences.setLoginStatus(loginStatus: true);

//         await UserSimplePreferences.setToken(
//             token: data["data"]["session_token"].toString());
//         Fluttertoast.showToast(
//           msg: data["message"],
//         );
//         // userprofilecontroller.userProfileNavigation();
//         // Get.toNamed(kNavigation);

//         print("object");
//       } else if (data["status"] == "error") {
//         Fluttertoast.showToast(
//           msg: response["message"],
//         );
//       } else {
//         Fluttertoast.showToast(
//           msg: data["message"],
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Something went wrong",
//       );
//     } finally {
//       userSignInLoading(false);
//     }
//   }
}
