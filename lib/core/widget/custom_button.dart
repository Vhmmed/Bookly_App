import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.backgroundColor, required this.textColor,  this.borderRadius, required this.text});

  final Color backgroundColor;
  final Color textColor;
  final BorderRadius? borderRadius;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:borderRadius ?? BorderRadius.circular(15),
          ),
          backgroundColor: backgroundColor,
        ),
        child:  Text(text,style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor ,
          fontFamily: 'Montserrat',
        ),),
      ),
    );
  }
}
