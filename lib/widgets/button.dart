import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function? onPress;
  final bool blockButton;

  const Button({
    Key? key,
    required this.title,
    this.onPress,
    required this.blockButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: blockButton ? double.infinity : 200,
        height: 50,
      ),
      child: ElevatedButton(
        child: Text(title),
        onPressed: () {
          onPress!();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          textStyle: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
