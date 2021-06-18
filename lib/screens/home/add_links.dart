import 'package:get/get.dart';
import 'package:sms_gateway/screens/home/home.controller.dart';
import 'package:sms_gateway/widgets/form/form.dart';
import 'package:sms_gateway/widgets/form/form_input.dart';
import 'package:flutter/material.dart';

class AddLinkForm extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();

  AddLinkForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: Obx(
        () => AppForm(
          onSubmit: (value) {
            _homeController.storeLinks(
                value['messagesLink'], value['responseLink']);
            Get.back();
          },
          inputs: [
            FormInput(
                name: 'messagesLink',
                label: 'Messages link',
                type: Type.text,
                value: _homeController.messagesLink.value,
                isRequired: true,
                options: []),
            FormInput(
              name: 'responseLink',
              label: 'Response link',
              type: Type.text,
              value: _homeController.responseLink.value,
              isRequired: false,
              options: [],
            ),
          ],
        ),
      ),
    );
  }
}
