import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget transactionButton({
  required VoidCallback onTap,
  required String buttonText,
  Color backgroundColor = Colors.white,
  Color fontColor = greyColor,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 42.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: greyColor.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: fontColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
