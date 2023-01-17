import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class customButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Color color;
  Color? textcolor;
  int? width;
  int? height;

  customButton(
      {required this.color,
      this.height,
      required this.onPressed,
      required this.text,
      this.width,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(12.0.w),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: Text(
        "$text",
        style: GoogleFonts.lato(
            color: textcolor == null ? Colors.black : textcolor,
            fontSize: 30.0.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
