import 'package:dots_picker/widgets/popup_painter.dart';
import 'package:flutter/material.dart';

class CustomPopUp extends StatelessWidget {
  final Color color;
  final String text;
  final double xcoord;
  final double height;

  const CustomPopUp({
    Key? key,
    required this.color,
    required this.text,
    this.xcoord = 0.5,
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: PopUpPainter(color, xcoord),
        child: Padding(
          padding: EdgeInsets.only(top: 2 * height / 5),
          child: Center(
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
