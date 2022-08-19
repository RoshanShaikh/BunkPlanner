import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {Key? key,
      required this.onPressed,
      this.radius = 45,
      required this.child})
      : super(key: key);
  final Function() onPressed;
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      elevation: 5,
      color: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.white,
        ),
        child: MaterialButton(
          elevation: 5,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          splashColor: Colors.lightBlue[100],
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
