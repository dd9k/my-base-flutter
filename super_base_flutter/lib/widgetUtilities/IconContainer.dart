import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Khoadd
/// 07/08/2021
///
class IconContainer extends StatelessWidget {
  const IconContainer(
      {Key key,
      @required this.icon,
      this.width,
      this.height,
      this.onTap,
      this.color,
      this.child,
      this.backgroundColor = Colors.transparent})
      : super(key: key);

  final IconData icon;
  final double width;
  final double height;
  final Function onTap;
  final Color color;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
            width: width == null ? 45 : width,
            height: height == null ? 45 : height,
            color: backgroundColor,
            child: child == null
                ? Icon(
                    icon,
                    color: color,
                  )
                : child),
      ),
    );
  }
}
