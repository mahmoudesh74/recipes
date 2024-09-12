import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottom extends StatelessWidget {
  final Color color;
  final String name;

  final double width;
  final double height;

  const CustomBottom(
      {super.key,
        required this.name,
        required this.width,
        required this.height,
        this.color = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(20.r)),
      child: Center(
          child: Text(
            name ?? "",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Colors.white),
          )),
    );
  }
}
