import 'package:get/get.dart';
import 'package:sms_gateway/screens/home/home.controller.dart';
import 'package:sms_gateway/screens/home/home.service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // Get.put(HomeService());
  }
}
