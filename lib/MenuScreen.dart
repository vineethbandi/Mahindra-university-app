import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mahindra_university/LoginScreen.dart';
import 'package:mahindra_university/ShowAnnouncementScreen.dart';
import 'package:mahindra_university/Utlis/CommonStyle.dart';
import 'package:mahindra_university/Utlis/colors.dart';

class MenuScreen extends StatefulWidget {
  final String? userRole;
  const MenuScreen({Key? key,this.userRole}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/Menu_bg_imge.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25, top: 25),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color(0xFFF8F8F8),
                            ))),
                  ),
                  SizedBox(height: height * .17),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * .25),
                        child: InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/home.png',
                                height: 24,
                                width: 24,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text(
                                  'HOME',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if(_auth.currentUser != null)...[
                    SizedBox(height: height * .02),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * .25),
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowAnnouncement(userRole: widget.userRole)));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.announcement_outlined,size: 22,color: AppColor.whiteColor,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    'Announcement',
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: width * .25),
                        child: Row(
                          children: [
                            Image.asset('assets/images/login.png',
                                height: 24, width: 24),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                          child: const Text(
                            'Parents Portal',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                          child: const Text(
                            'Faculty Portal',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                          child: const Text(
                            'Students  Portal',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                letterSpacing: 1,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if(_auth.currentUser != null)...[
                    SizedBox(height: height * .02),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * .25),
                          child: InkWell(
                            onTap: () async {
                              CommonStyle.showLoadingDialog(context);
                              _auth.signOut();
                              Navigator.pop(context);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                      (route) => false);
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.logout,
                                  color: AppColor.whiteColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    'Log out',
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
