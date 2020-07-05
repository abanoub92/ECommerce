import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientRaisedButton extends StatelessWidget {

  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const GradientRaisedButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient, 
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          )
        ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}