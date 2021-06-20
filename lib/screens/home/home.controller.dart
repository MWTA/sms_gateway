import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:sms_gateway/screens/home/home.repository.dart';
import 'package:sms_gateway/screens/home/home.service.dart';
import 'package:sms_gateway/screens/home/message.model.dart';

class HomeController extends GetxController {
  late HomeService _homeService;
  late HomeRepository _homeRepository;

  final Telephony telephony = Telephony.instance;
  final int messagesAlarmId = 1;
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  RxString messagesLink = ''.obs;
  RxString responseLink = ''.obs;
  RxString newMessageLink = ''.obs;
  RxBool gateWayisEnabled = false.obs;
  RxList<Message> queuedMessages = RxList();
  RxList<Message> sentMessages = RxList();
  RxList<Message> incomingMessages = RxList();
  RxList<Message> uploadedMessages = RxList();
  Rx<Message> currenReceivedMessage = Message(
    id: '',
    phone: '',
    message: '',
    status: '',
  ).obs;
  Rx<Message> currentSendingMessage = Message(
    id: '',
    phone: '',
    message: '',
    status: '',
  ).obs;

  HomeController() {
    _homeService = Get.put(HomeService());
    _homeRepository = HomeRepository();
  }

  @override
  void onInit() async {
    super.onInit();
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        currenReceivedMessage.value = Message(
          id: message.id.toString(),
          phone: message.address ?? 'Unknown',
          message: message.body ?? '',
          status: 'received',
        );
        incomingMessages.add(currenReceivedMessage.value);
        _handleIncomingMessage(message);
      },
      listenInBackground: false,
      //onBackgroundMessage: _handleIncomingMessage,
    );
    getMessages();
    getLinks();
    gateWayisEnabled.value = await _homeRepository.getGatewayStatus();
  }

  void getMessages() async {
    final result = await _homeService.getMessages();

    if (result != null) {
      queuedMessages.addAll(result.obs);
      sendMessages();
    }
  }

  void storeLinks(
      String messagesLink, String responseLink, String newMessageLink) {
    _homeRepository.storeLink(name: 'messagesLink', value: messagesLink);
    _homeRepository.storeLink(name: 'responseLink', value: responseLink);
    _homeRepository.storeLink(name: 'newMessageLink', value: newMessageLink);
  }

  void getLinks() async {
    messagesLink.value = await _homeRepository.getLink(name: 'messagesLink');
    responseLink.value = await _homeRepository.getLink(name: 'responseLink');
    newMessageLink.value =
        await _homeRepository.getLink(name: 'newMessageLink');
  }

  void enableDisableGateway(bool enable) {
    gateWayisEnabled.value = enable;
    _homeRepository.storeGatewayStatus(value: enable);
    if (enable) {
      sendMessages();
    }
  }

  void sendMessages() async {
    int i = 0;
    while (i < queuedMessages.length) {
      if (!gateWayisEnabled.value) {
        break;
      }
      await _sendSMS(queuedMessages[i]);
      i = 0;
    }
  }

  _handleIncomingMessage(SmsMessage message) async {
    final result = await _homeService
        .uploadNewMessage(message.address ?? 'Unknown', body: message.body);

    if (result != null) {
      incomingMessages.remove(currenReceivedMessage.value);
      uploadedMessages.add(currenReceivedMessage.value);
      currenReceivedMessage.value = Message(
        id: '',
        phone: '',
        message: '',
        status: '',
      );
      sendMessages();
    }
  }

  Future<void> _sendSMS(Message message) async {
    final SmsSendStatusListener listener = (SendStatus status) {
      _handleSmsStatus(message, status);
    };
    if (gateWayisEnabled.value) {
      await Future.delayed(const Duration(milliseconds: 500), () {
        currentSendingMessage.value = Message(
          id: message.id,
          phone: message.phone,
          message: message.message,
          status: message.status,
        );
        telephony.sendSms(
          to: message.phone,
          message: message.message,
          isMultipart: message.message.length > 160,
          statusListener: listener,
        );
        queuedMessages.remove(message);
        sentMessages.add(message);
      });
    }
  }

  _handleSmsStatus(Message message, SendStatus status) {
    switch (status) {
      case SendStatus.DELIVERED:
        sentMessages.remove(message);
        _homeService.sendResponse(message.id, status: 'delivered');
        break;
      case SendStatus.SENT:
        break;
      default:
        sentMessages.remove(message);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
