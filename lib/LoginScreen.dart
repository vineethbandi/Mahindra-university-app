import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mahindra_university/Utlis/CommonStyle.dart';
import 'package:mahindra_university/Utlis/ImageRes.dart';
import 'package:mahindra_university/Utlis/colors.dart';
import 'package:mahindra_university/Utlis/commonString.dart';
import 'package:mahindra_university/appUserModel.dart';

import 'homeScreen.dart';

enum userRole {
  student,
  parents,
  faculty,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String get interBold => 'InterBold';

  String get interRegular => 'InterRegular';
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscured = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppUser? appUser;
  final _formKey = GlobalKey<FormState>();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured; // Prevents focus if tap on eye
    });
  }

  @override
  void initState() {
    locationP();
    super.initState();
  }

  locationP() async {
    await CommonStyle.getLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: height * .15),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Container(
                        // width: width,
                        decoration: BoxDecoration(color: AppColor.loginContainerColor, borderRadius: BorderRadius.circular(25)),
                        // alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 42, bottom: 35),
                          child: Column(
                            children: [
                              Text(
                                CommonString.welcomeString,
                                textAlign: TextAlign.center,
                                style: CommonStyle.commonBoldTextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor,
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: interBold),
                              ),
                              SizedBox(
                                height: height * .07,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      CommonString.userString,
                                      style: CommonStyle.commonBoldTextStyle(
                                          fontWeight: FontWeight.w700, color: AppColor.whiteColor, fontSize: 10, fontFamily: interBold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 11, bottom: 11),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please Enter Email";
                                    }
                                    return null;
                                  },
                                  controller: userNameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    errorStyle: TextStyle(color: Colors.white),
                                    fillColor: AppColor.whiteColor,
                                    hintText: CommonString.enterUsernameString,
                                    hintStyle: CommonStyle.commonBoldTextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.blackColor.withOpacity(0.40),
                                        fontSize: 10,
                                        fontFamily: interBold),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      CommonString.passwordString,
                                      style: CommonStyle.commonBoldTextStyle(
                                          fontWeight: FontWeight.w700, color: AppColor.whiteColor, fontSize: 10, fontFamily: interBold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 11, bottom: 11),
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                  obscureText: _obscured,

                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColor.whiteColor,
                                    hintText: CommonString.enterPasswordString,
                                    hintStyle: CommonStyle.commonBoldTextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.blackColor.withOpacity(0.40),
                                        fontSize: 10,
                                        fontFamily: interBold),
                                    errorStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedErrorBorder:  OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    enabledBorder:  OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent,),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                                    suffixIcon: GestureDetector(
                                      onTap: _toggleObscured,
                                      child: Icon(
                                        _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                        size: 24,
                                        color: AppColor.blackColor.withOpacity(0.40),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * .04),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 22),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        CommonStyle.showLoadingDialog(context);
                                        try {
                                          if (_auth.currentUser != null) {
                                            _auth.signOut();
                                          }
                                          await _auth
                                              .signInWithEmailAndPassword(email: userNameController.text, password: passwordController.text)
                                              .then((value) async {
                                            appUser = AppUser.fromJson(
                                                (await FirebaseFirestore.instance.collection("users").doc(value.user!.uid).get()).data()!);
                                            print("appUser :: ${appUser!.userType}");
                                            if (appUser!.userType == 'student') {
                                              if (await Geolocator.isLocationServiceEnabled()) {
                                                Position position = await CommonStyle.determinePosition();
                                                DocumentReference groupDocumentReference =
                                                    FirebaseFirestore.instance.collection("users").doc(value.user!.uid);
                                                await groupDocumentReference.update({
                                                  "current_latitude": position.latitude,
                                                  "current_longitude": position.longitude,
                                                });
                                                Navigator.pop(context);
                                                Navigator.of(context).pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) => HomeScreen(
                                                              userRole: appUser!.userType.toString(),
                                                            )),
                                                    (route) => false);
                                              } else {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      "Please turn on location",
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            } else {
                                              Navigator.pop(context);
                                              Navigator.of(context).pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) => HomeScreen(
                                                            userRole: appUser!.userType.toString(),
                                                          )),
                                                  (route) => false);
                                            }
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          // TODO
                                          Navigator.pop(context);
                                          print("Error ${e.message}");
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                e.message.toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        } catch (error) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                error.toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          print("Error sdffg$error");
                                        }
                                      }
                                    },
                                    style: CommonStyle.buildButtonStyle3(),
                                    child: Text(
                                      CommonString.loginString,
                                      style: CommonStyle.commonBoldTextStyle(color: AppColor.whiteColor, fontSize: 14, fontWeight: FontWeight.w800),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 35, left: 25, right: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      CommonString.forgotPasswordString,
                                      style: CommonStyle.commonBoldTextStyle(color: AppColor.whiteColor, fontSize: 8, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 32),
                                    child: Row(
                                      children: [
                                        Image.asset(ImageRes.backArrow, height: 18, width: 18),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          CommonString.backString,
                                          style: CommonStyle.commonBoldTextStyle(color: AppColor.whiteColor, fontSize: 12, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .12),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.asset(
                        ImageRes.logo,
                        height: 40,
                        width: 120,
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(height: height *.12),
              // Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
