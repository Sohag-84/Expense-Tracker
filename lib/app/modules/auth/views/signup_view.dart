import 'package:expense_tracker/app/modules/auth/controllers/auth_controller.dart';
import 'package:expense_tracker/app/modules/auth/widgets/build_textfield.dart';
import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:expense_tracker/core/app_images.dart';
import 'package:expense_tracker/core/theme/colors.dart';
import 'package:expense_tracker/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final controller = Get.find<AuthController>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                'Create Account',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Gap(20.h),
              // Name Input Field
              buildTextField(
                controller: _nameController,
                hintText: 'Name',
                icon: Icons.person_outline,
              ),
              Gap(12.h),
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
              ),
              Gap(12.h),
              // Confirm Password Input Field
              buildTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                icon: Icons.lock_outline,
              ),
              Gap(20.h),
              // Login Button
              customButton(
                onTap: () async {
                  if (_nameController.text.trim().isEmpty) {
                    Get.snackbar("Error", "Name can't be empty");
                    return;
                  }
                  if (_emailController.text.trim().isEmpty) {
                    Get.snackbar("Error", "Email can't be empty");
                    return;
                  }
                  if (_passwordController.text.trim().isEmpty) {
                    Get.snackbar("Error", "Password can't be empty");
                    return;
                  }
                  if (_passwordController.text.toString() !=
                      _confirmPasswordController.text.toString()) {
                    Get.snackbar("Error", "Password doesn't match");
                    return;
                  }
                  await controller.register(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
                buttonText: "Sign Up",
                height: 48.h,
              ),
              Gap(20.h),
              // Already have an account? Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(
                      'Login',
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
