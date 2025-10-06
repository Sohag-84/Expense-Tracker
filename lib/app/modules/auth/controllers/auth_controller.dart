import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:expense_tracker/core/constant/firebase_constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  // user registration
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    EasyLoading.show(status: "Loading....");
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      // Save user info in firestore
      await firestore.collection(userCollection).doc(user!.uid).set({
        "uid": user.uid,
        "name": name,
        "email": email,
        "createdAt": DateTime.now(),
      });

      Get.snackbar("Success", "Account created successfully");
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      String error = _handleAuthError(e);
      Get.snackbar("Error", error);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  //user login
  Future<void> login({required String email, required String password}) async {
    EasyLoading.show(status: "Loading....");
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("Success", "Login successful");
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      String error = _handleAuthError(e);
      Get.snackbar("Error", error);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  //user logout
  Future<void> logout() async {
    await firebaseAuth.signOut();
    Get.offAndToNamed(Routes.LOGIN);
  }

  // error handler
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return "The email address is badly formatted.";
      case "user-disabled":
        return "This user has been disabled.";
      case "user-not-found":
        return "No user found with this email.";
      case "wrong-password":
        return "Wrong password provided.";
      case "email-already-in-use":
        return "This email is already registered.";
      case "weak-password":
        return "Password should be at least 6 characters.";
      case "invalid-credential":
        return "Invalid Credential";
      case "too-many-requests":
        return "Too many login attempts. Try again later.";
      case "network-request-failed":
        return "Network error. Check your internet connection.";
      default:
        return "Something went wrong. Please try again.";
    }
  }
}
