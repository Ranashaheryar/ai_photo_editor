import 'package:get/get.dart';

import '../controllers/applovin_ctl.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppLovin_CTL());

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
