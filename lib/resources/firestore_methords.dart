import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreMethods {
static  void createUser(
      BuildContext context,
      CollectionReference usersCollection,
      TextEditingController nameController,
      TextEditingController emailController) async {
    try {
      await usersCollection.add({
        'name': nameController.text,
        'email': emailController.text,
      });
      nameController.clear();
      emailController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User created successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create user')),
      );
    }
  }

 static void updateUser(
      BuildContext context,
      DocumentSnapshot userSnapshot,
      TextEditingController nameController,
      TextEditingController emailController) async {
    try {
      await userSnapshot.reference.update({
        'name': nameController.text,
        'email': emailController.text,
      });
      nameController.clear();
      emailController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User updated successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user')),
      );
    }
  }

 static void deleteUser(
      BuildContext context, DocumentSnapshot userSnapshot) async {
    try {
      await userSnapshot.reference.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User deleted successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user')),
      );
    }
  }
}
