import 'package:flutter/material.dart';

class Buttons {
  Widget customButton(VoidCallback? function, Widget widget, Color color) {
    return InkWell(
      onTap: function,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 70),
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: widget),
    );
  }
}
