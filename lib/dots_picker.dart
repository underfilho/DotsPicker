library dots_picker;

import 'dart:async';
import 'package:collection/collection.dart';
import 'package:dots_picker/dot.dart';
import 'package:dots_picker/widgets/custom_popup.dart';
import 'package:flutter/material.dart';

class DotsPicker extends StatefulWidget {
  final List<Dot> dots;
  final Function(int)? onSelected;
  final int selected;
  final int exposureTime;

  const DotsPicker({
    required this.dots,
    this.onSelected,
    this.selected = 0,
    this.exposureTime = 1,
    Key? key,
  }) : super(key: key);

  @override
  State<DotsPicker> createState() => _DotsPickerState();
}

class _DotsPickerState extends State<DotsPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late CurvedAnimation _curve;
  late int selected;
  Timer? _timerReverse;
  OverlayEntry? _overlayEntry;
  List<GlobalKey> _keys = [];

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
    _animController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _curve = CurvedAnimation(parent: _animController, curve: Curves.easeInOut);
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _timerReverse = Timer(Duration(seconds: widget.exposureTime),
            () => _animController.reverse());
    });

    _keys =
        widget.dots.mapIndexed((i, e) => LabeledGlobalKey('dot$i')).toList();
  }

  @override
  void dispose() {
    closePopUp();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.dots.mapIndexed((i, dot) {
        return Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              if (i == selected) {
                showPopUp();
              } else {
                selected = i;
                showPopUp();
                setState(() {});
                if (widget.onSelected != null) widget.onSelected!(i);
              }
            },
            child: Container(
              key: _keys[i],
              height: 30,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.5,
                  color: (i == selected) ? dot.color : Colors.transparent,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: dot.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void showPopUp() {
    _animController.reset();
    closePopUp();

    _overlayEntry = _overlayEntryBuilder();
    _animController.forward();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void closePopUp() {
    if (_timerReverse != null && _timerReverse!.isActive)
      _timerReverse?.cancel();

    if (isPopupOpen) _overlayEntry?.remove();
  }

  bool get isPopupOpen {
    if (_overlayEntry == null) return false;
    return _overlayEntry!.mounted;
  }

  OverlayEntry _overlayEntryBuilder() {
    RenderBox renderBox =
        _keys[selected].currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset position = renderBox.localToGlobal(Offset.zero);
    double width = 150;
    double xcoord = 0.5;

    return OverlayEntry(builder: (context) {
      var screenWidth = MediaQuery.of(context).size.width;
      if (position.dx < 100) xcoord = 0.3;
      if (position.dx + size.width > screenWidth - 100) xcoord = 0.7;

      return Positioned(
        top: position.dy + size.height - 5.0,
        left:
            ((0.5 - xcoord) * width) + position.dx - width / 2 + size.width / 2,
        width: width,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            alignment: Alignment((xcoord - 0.5) * 2, -1),
            scale: _curve,
            child: CustomPopUp(
              xcoord: xcoord,
              color: widget.dots[selected].color,
              text: widget.dots[selected].name,
            ),
          ),
        ),
      );
    });
  }
}
