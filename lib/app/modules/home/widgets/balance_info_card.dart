import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@override
Widget balanceInfoCard({
  required String title,
  required String amount,
  required List<Color> gradientColors,
  required IconData icon,
}) {
  return Container(
    height: 150,
    padding: EdgeInsets.all(5.w),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: blackColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "৳ $amount",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 20,
          backgroundColor: whiteColor.withValues(alpha: 0.3),
          child: Icon(icon, color: whiteColor, size: 22),
        ),
      ],
    ),
  );
}
