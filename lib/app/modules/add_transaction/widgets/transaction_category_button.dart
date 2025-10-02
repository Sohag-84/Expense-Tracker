import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget transactionCategoryButton({
  required VoidCallback onTap,
  required IconData icon,
  required String title,
  Color backgroundColor = whiteColor,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 70.h,
      width: 70.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: greyColor.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(7.h),
            decoration: BoxDecoration(color: darkWhite, shape: BoxShape.circle),
            child: Icon(icon),
          ),
          Gap(2.h),
          Text(title, style: TextStyle(fontSize: 10.sp)),
        ],
      ),
    ),
  );
}
