import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_app/UI/theme.dart';

class TheButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const TheButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
       width: 110,
       height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: primarycolor
        ),
        child: Text(
          label,
          textAlign:TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            color: Colors.white,
          ),


        ),
      ),

    );
  }
}
