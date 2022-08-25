import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {Key? key,
      required this.onPressed,
      this.radius = 45,
      this.color = Colors.white,
      this.splashColor,
      required this.child})
      : super(key: key);
  final Function() onPressed;
  final double radius;
  final Widget child;
  final Color color;
  final Color? splashColor;

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
          color: color,
        ),
        child: MaterialButton(
          elevation: 5,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          splashColor: splashColor,
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
