import 'package:get/get.dart';
import 'package:sms_gateway/screens/home/home.binding.dart';
import 'package:sms_gateway/screens/home/home.view.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: '/',
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
