import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mahindra_university/appUserModel.dart';
import 'package:mahindra_university/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppUser? appUser;
  @override
  void initState() {
    getUserData();
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        if(_auth.currentUser != null){
          Navigator.of(context)
              .pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(userRole: appUser!.userType!,)),
                  (route) => false);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }

      }
    );
  }

  getUserData() async {
    if(_auth.currentUser != null){
    appUser = AppUser.fromJson((await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser!.uid).get()).data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: const Color(0xFFE92742),
        child: Image.asset('assets/images/splash_logo.png'),
      ),
    );
  }
}
