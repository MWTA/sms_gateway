import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  Future<void> storeLink({required String name, required String value}) async {
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(name, value).then((bool success) {
      return value;
    });
  }

  Future<void> storeGatewayStatus({required bool value}) async {
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setBool('gateWayisEnabled', value).then((bool success) {
      return value;
    });
  }

  Future<dynamic> getLink({required String name}) async {
    final SharedPreferences prefs = await sharedPreferences;
    return prefs.getString(name) ?? '';
  }

  Future<bool> getGatewayStatus() async {
    final SharedPreferences prefs = await sharedPreferences;
    bool status = prefs.getBool('gateWayisEnabled') ?? false;
    return status;
  }
}
