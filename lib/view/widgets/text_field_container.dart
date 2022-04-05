import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: padding/2),
      padding:  EdgeInsets.symmetric(horizontal: padding, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(containerRoundCorner),
      ),
      child: Center(
        child: child
      ),
    );
  }
}
