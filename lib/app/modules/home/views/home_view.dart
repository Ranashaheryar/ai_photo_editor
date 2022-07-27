// ignore_for_file: prefer_const_constructors

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_editor/app/utils/app_colors.dart';
import 'package:image_editor/app/utils/app_strings.dart';
import 'package:image_editor/app/utils/sizeconfig.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('HomeView'),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(color: AppColors.HomeBG),
          ),
          Container(
            decoration: BoxDecoration(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,

              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 8,
                      vertical: SizeConfig.blockSizeVertical * 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Photo Editor",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      verticalSpace(SizeConfig.blockSizeVertical * 2),
                      Row(
                        children: [
                          _EditButton(),
                          horizontalSpace(SizeConfig.blockSizeHorizontal * 3),
                          Expanded(
                            child: Container(
                                height: SizeConfig.blockSizeVertical * 17,
                                child: Column(
                                  children: [
                                    Expanded(flex: 1, child: _CameraButton()),
                                    verticalSpace(
                                        SizeConfig.blockSizeVertical * 2),
                                    Expanded(
                                        flex: 1, child: _CollectionButton())
                                  ],
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 8,
                vertical: SizeConfig.blockSizeVertical * 10),
            width: SizeConfig.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaxAdView(
                    adUnitId: AppStrings.MAX_MREC_ID,
                    adFormat: AdFormat.mrec,
                    listener: AdViewAdListener(onAdLoadedCallback: (ad) {
                      print('MREC widget ad loaded from ' + ad.networkName);
                    }, onAdLoadFailedCallback: (adUnitId, error) {
                      print('MREC widget ad failed to load with error code ' +
                          error.code.toString() +
                          ' and message: ' +
                          error.message);
                    }, onAdClickedCallback: (ad) {
                      print('MREC widget ad clicked');
                    }, onAdExpandedCallback: (ad) {
                      print('MREC widget ad expanded');
                    }, onAdCollapsedCallback: (ad) {
                      print('MREC widget ad collapsed');
                    })),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _CameraButton() {
    return InkWell(
      onTap: () {
        controller.getImageFromCamera();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 2,
            vertical: SizeConfig.blockSizeVertical * 1),
        decoration: BoxDecoration(
          color: Color(0xFFFB9435),
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
        ),
        child: Row(
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: AppColors.PrimaryIconColor,
            ),
            horizontalSpace(SizeConfig.blockSizeHorizontal * 2),
            Text("Camera",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _CollectionButton() {
    return GestureDetector(
      onTap: () {
        controller.getImage();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 2,
            vertical: SizeConfig.blockSizeVertical * 1),
        decoration: BoxDecoration(
          color: Color(0xFF11D0C9),
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
        ),
        child: Row(
          children: [
            Icon(Icons.photo_library_outlined, color: Colors.white),
            horizontalSpace(SizeConfig.blockSizeHorizontal * 2),
            Text("Collection",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _EditButton() {
    return InkWell(
      onTap: () {
        controller.getImage();
      },
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 33,
        height: SizeConfig.blockSizeVertical * 17,
        decoration: BoxDecoration(
          color: AppColors.editConatiner,
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.wand_stars_inverse,
                color: AppColors.PrimaryIconColor),
            verticalSpace(SizeConfig.blockSizeVertical * 1),
            Text("Edit", style: TextStyle(fontSize: 18, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
