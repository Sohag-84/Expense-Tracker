import 'package:expense_tracker/app/modules/auth/widgets/build_textfield.dart';
import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:expense_tracker/core/app_images.dart';
import 'package:expense_tracker/core/theme/colors.dart';
import 'package:expense_tracker/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(AppImages.appIcon, height: 150.h, width: 150.w),
              Gap(30.h),
              // Welcome Back! text
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Gap(20.h),
              // Email Input Field
              buildTextField(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email_outlined,
              ),
              Gap(12.h),
              // Password Input Field
              buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              Gap(20.h),
              // Login Button
              customButton(
                onTap: () {
                  Get.toNamed(Routes.ADD_TRANSACTION);
                },
                buttonText: "Login",
                height: 48.h,
              ),
              Gap(20.h),
              // Don't have an account? Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
