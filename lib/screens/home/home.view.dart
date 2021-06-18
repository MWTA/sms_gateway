import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_gateway/screens/home/add_links.dart';
import 'package:sms_gateway/screens/home/home.controller.dart';

class HomeView extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'SMS Gateway',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.black,
            onPressed: () {
              _homeController.getMessages();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.black,
            onPressed: () {
              Get.bottomSheet(
                AddLinkForm(),
                backgroundColor: Colors.white,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 450,
              child: GridView.count(
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                crossAxisCount: 2,
                childAspectRatio: .90,
                children: [
                  Card(
                    elevation: 2,
                    color: Color(0xffefe3f4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Obx(
                            () => _countText(_homeController
                                .queuedMessages.length
                                .toString()),
                          ),
                          _tileText('Queued messages'),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    color: Color(0xffe4e9f5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Obx(
                            () => _countText(
                                _homeController.sentMessages.length.toString()),
                          ),
                          _tileText('Sent messages'),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    color: Color(0xffe3f0e4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Obx(
                            () => _countText(_homeController
                                .deliveredMessages.length
                                .toString()),
                          ),
                          _tileText('Delivered messages'),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    color: Color(0xfff5e6e2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Obx(
                            () => _countText(_homeController
                                .failedMessages.length
                                .toString()),
                          ),
                          _tileText('Failed messages'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 185,
                    child: ElevatedButton(
                      child: Text('Start Gateway'),
                      onPressed: () {
                        _homeController.enableDisableGateway(true);
                      },
                      style: buttonStyle(Colors.orange[300]),
                    ),
                  ),
                  SizedBox(
                    width: 185,
                    child: ElevatedButton(
                      child: Text('Stop Gateway'),
                      onPressed: () {
                        _homeController.enableDisableGateway(false);
                      },
                      style: buttonStyle(Colors.red[400]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                color: Colors.black,
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: 250,
                  minWidth: double.infinity,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _consoleText(
                        _homeController.currentMessage.value.phone != ''
                            ? 'Sending to:'
                            : '',
                        fontSize: 15,
                        color: Color(0xff216e85),
                      ),
                      _consoleText(
                        _homeController.currentMessage.value.phone,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _consoleText(
                        _homeController.currentMessage.value.phone != ''
                            ? 'Message:'
                            : '',
                        fontSize: 15,
                        color: Color(0xff216e85),
                      ),
                      _consoleText(
                        _homeController.currentMessage.value.message,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _consoleText(String text,
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 9,
      style: TextStyle(
        fontSize: fontSize ?? 25,
        color: color ?? Colors.green[700],
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }

  Widget _countText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 25,
        color: Color(0xff404557),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _tileText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        color: Color(0xff404557),
      ),
    );
  }

  ButtonStyle buttonStyle(Color? color) {
    return ElevatedButton.styleFrom(
      primary: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      textStyle: TextStyle(
        fontSize: 17,
      ),
    );
  }
}
