import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sms_gateway/router.dart';
import 'package:sms_gateway/screens/home/home.view.dart';

void main() async {
  // handleIncomingMessage(SmsMessage message) async {
  //   HomeService()
  //       .uploadNewMessage(message.address ?? 'Unknown', body: message.body);
  // }

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      getPages: AppRouter.routes,
      initialRoute: '/',
      home: HomeView(),
    );
  }
}
