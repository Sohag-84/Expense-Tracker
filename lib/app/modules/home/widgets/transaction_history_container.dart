import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget transactionHistoryContainer({
  required String title,
  required String type,
  required String date,
  required double amount,
  required IconData icon,
  required Color transactionColor,
}) {
  return Container(
    height: 60.h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: whiteColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8.w,
          decoration: BoxDecoration(
            color: transactionColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              bottomLeft: Radius.circular(8.r),
            ),
          ),
        ),
        Gap(5.w),
        Container(
          height: 30.h,
          width: 30.w,
          alignment: Alignment.center,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: transactionColor.withValues(alpha: 0.2),
          ),
          child: Icon(icon, size: 22.h, color: transactionColor),
        ),
        Gap(10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$title | $type",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(date),
            ],
          ),
        ),
        Text(
          '৳ ${amount.toStringAsFixed(2)}',
          style: TextStyle(color: transactionColor),
        ),
      ],
    ),
  );
}
