import 'dart:io';
import 'dart:async';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor/app/data/my_preset_filter.dart';
import 'package:image_editor/app/modules/home/controllers/applovin_ctl.dart';
import 'package:image_editor/app/routes/app_pages.dart';
import 'package:image_editor/app/utils/com_func.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;

class HomeController extends GetxController {
  //TODO: Implement HomeController
  String? fileName;
  List<Filter> filters = myPresetFiltersList;
  final picker = ImagePicker();
  File? imageFile;
  imageLib.Image? image;

  final count = 0.obs;
  AppLovin_CTL appLovin_CTL = Get.find();
  @override
  void onInit() {
    super.onInit();
    CM.initializeLoader();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future getImage() async {
    CM.showProgressLoader("Loading Image...");

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = new File(pickedFile.path);
      fileName = basename(imageFile!.path);
      // var image = imageLib.decodeImage(await imageFile!.readAsBytes());
      image = imageLib.decodeImage(await imageFile!.readAsBytes());
      image = imageLib.copyResize(image!, width: 600);
      CM.hideProgressLoader();
      appLovin_CTL.showInterstitial();
      Get.toNamed(Routes.FilterImageView);
    } else {
      CM.hideProgressLoader();
    }
  }

  Future getImageFromCamera() async {
    CM.showProgressLoader("Loading Image...");

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = new File(pickedFile.path);
      fileName = basename(imageFile!.path);
      // var image = imageLib.decodeImage(await imageFile!.readAsBytes());
      image = imageLib.decodeImage(await imageFile!.readAsBytes());
      image = imageLib.copyResize(image!, width: 600);
      CM.hideProgressLoader();
      appLovin_CTL.showInterstitial();

      Get.toNamed(Routes.FilterImageView);
    } else {
      CM.hideProgressLoader();
    }
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    // _toastInfo(info);
  }
}
