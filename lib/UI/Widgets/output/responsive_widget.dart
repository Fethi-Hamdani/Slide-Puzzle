import 'package:flutter/material.dart';

class ResponsiveWidget extends StatefulWidget {
  final Widget small;
  final Widget medium;
  final Widget large;
  const ResponsiveWidget({
    Key? key,
    this.small = const SizedBox(),
    this.medium = const SizedBox(),
    this.large = const SizedBox(),
  }) : super(key: key);

  @override
  _ResponsiveWidgetState createState() => _ResponsiveWidgetState();
}

class _ResponsiveWidgetState extends State<ResponsiveWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width <= 425
        ? widget.small
        : width <= 1024
            ? widget.medium
            : widget.large;
  }
}
