import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view/crud/home.dart';

class Users extends GetxController {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  String errorText = '';
  login() async {
    return await users.where('email', isEqualTo: email.text).where('passwd', isEqualTo: passwd.text).get().then((QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          Get.off(() => Home(email.text));
          errorText = '';
          update();
        } else {
          errorText = 'Email or password is incorrect!';
          update();
        }
      });
  }
}
