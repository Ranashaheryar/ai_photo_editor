import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_editor/app/utils/app_colors.dart';




class CM {
  static bool validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static showExitDialog({
    required String title,
    required String msg,
  }) {
    Get.defaultDialog(
        title: title,
        middleText: msg,
        textConfirm: "Yes",
        textCancel: "No",
        onCancel: () {
          // Get.back();
        },
        onConfirm: () {
          SystemNavigator.pop();
        },
        titleStyle: TextStyle(color: Colors.blue),
        confirmTextColor: Colors.white);
  }


  static showInfoDialog({
    required String title,
    required String msg,
  }) {
    Get.defaultDialog(
        title: title,
        middleText: msg,
        radius: 10,
       
        textConfirm: "OK",
        onConfirm: () {
          Get.back();
        },
        titleStyle: TextStyle(color: Colors.blue),
        confirmTextColor: Colors.white);
  }

  static bool showConfirmDialog({
    required String title,
    required String msg,
  }) {
    bool confirm=false;
    Get.defaultDialog(
        title: title,
        middleText: msg,
        radius: 10,
       
        textConfirm: "OK",
        onConfirm: () {
          confirm=true;
          Get.back();

        },
        onCancel:() {
          confirm=false;

        },
       
        titleStyle: TextStyle(color: Colors.blue),
        confirmTextColor:Colors.white);
 
 return confirm;
  }


  

 

  // static showToast(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       backgroundColor: AppColor.primaryBlue,
  //       textColor: AppColor.white,
  //       fontSize: 16.0);
  // }

  static showProgressLoader(String msg) {
    EasyLoading.show(status: msg);
  }

  static hideProgressLoader() {
    EasyLoading.dismiss();
  }

  static void initializeLoader() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 60
      ..radius = 20
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.blue
      ..textColor = Colors.white
      ..userInteractions = true
      ..dismissOnTap = false
      ..indicatorType = EasyLoadingIndicatorType.circle;
  }
}
