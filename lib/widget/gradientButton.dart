import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class gradientButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Color? color;
  Color? textcolor;
  int? width;
  double? height;
  int? fontSize;

  gradientButton(
      {
         this.fontSize,
         this.color,
      this.height,
      required this.onPressed,
      required this.text,
      this.width,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0 ],
            colors: [
              Colors.orange,
              Colors.white,
              Colors.green,
            ],
          ),
          border: Border.all(color: Colors.black,width: 2),
          color: Colors.orange
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // elevation: MaterialStateProperty.all(12.0.w),
          // shape: MaterialStateProperty.all(
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent)
        ),
        child: Text(
          "$text",
          style: GoogleFonts.lato(
              color: textcolor == null ? Colors.black : textcolor,
              fontSize: fontSize == null ? 40.0.sp : fontSize?.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
