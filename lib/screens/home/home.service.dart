import 'package:get/get.dart';
import 'package:sms_gateway/http/http_service.dart';
import 'package:sms_gateway/screens/home/home.repository.dart';
import 'package:sms_gateway/screens/home/message.model.dart';

class HomeService {
  late HttpService _httpService;
  late HomeRepository _homeRepository;

  HomeService() {
    _homeRepository = HomeRepository();
    _httpService = Get.put(HttpService(baseUrl: ''));
  }

  Future<List<Message>?> getMessages() async {
    try {
      final response = await _httpService.get(
        url: await _homeRepository.getLink(name: 'messagesLink'),
      );

      final _messages = List<Message>.from(
        response.data.map(
          (x) => Message.fromJson(x),
        ),
      );
      return _messages;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Message?> sendResponse(String messageId, {String? status}) async {
    String baseUrl = await _homeRepository.getLink(name: 'responseLink');
    try {
      final response = await _httpService.put(
        url: '$baseUrl/$messageId',
        body: {
          'status': status ?? 'delivered',
        },
      );
      return Message.fromJson(response.data);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Message?> uploadNewMessage(String phone, {String? body}) async {
    String baseUrl = await _homeRepository.getLink(name: 'newMessageLink');
    try {
      final response = await _httpService.post(
        url: '$baseUrl',
        body: {
          'phone': phone,
          'body': body ?? '',
        },
      );
      return Message.fromJson(response.data);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
