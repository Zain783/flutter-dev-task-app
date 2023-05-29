import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_test_app/models/userModel.dart' as MyUser;
import 'package:my_test_app/utils/utils.dart'; // Import with a custom name

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      // Registering user in auth with email and password
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser.UserModel _user = MyUser.UserModel(
          name: name,
          email: email,
          password: password); // Use the fully qualified name

      await _firestore
          .collection("users")
          .doc(cred.user!.uid)
          .set(_user.toMap());
      res = "success";
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, "Check Your Email");
    } catch (error) {
      throw error.toString();
    }
  }
}
