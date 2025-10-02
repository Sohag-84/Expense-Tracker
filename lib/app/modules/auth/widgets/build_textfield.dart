import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool isPassword = false,
}) {
  return Container(
    height: 55.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: greyColor.withValues(alpha: 0.5)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey, size: 24.h),
        suffixIcon: isPassword
            ? Icon(Icons.visibility_off, color: Colors.grey, size: 24.h)
            : null,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 12.w),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      style: TextStyle(fontSize: 16.sp),
    ),
  );
}
