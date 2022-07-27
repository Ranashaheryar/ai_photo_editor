import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor/app/data/my_preset_filter.dart';
import 'package:image_editor/app/modules/home/controllers/home_controller.dart';
import 'package:image_editor/app/modules/home/views/my_photo_filter.dart';


class FilterImageView extends StatelessWidget {
 
  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:    PhotoFilterSelector(
            title: Text("Photo Filter Example"),
            image: controller.image!,
            filters: myPresetFiltersList,
            filename: controller.fileName!,
            loader: Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
    );
    
  }
}