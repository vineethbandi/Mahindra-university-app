import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahindra_university/LoginScreen.dart';
import 'package:mahindra_university/MenuScreen.dart';
import 'package:mahindra_university/Utlis/CommonStyle.dart';
import 'package:mahindra_university/Utlis/ImageRes.dart';
import 'package:mahindra_university/Utlis/colors.dart';
import 'package:mahindra_university/Utlis/commonString.dart';
import 'package:mahindra_university/appUserModel.dart';
import 'package:mahindra_university/mapView.dart';

class HomeScreen extends StatefulWidget {
  String? userRole;

  HomeScreen({Key? key, this.userRole}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imgList = [
    ImageRes.slider1,
    ImageRes.slider2,
    ImageRes.slider3,
  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppUser? appUser;
  AppUser? studentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: widget.userRole == userRole.parents.name
            ? _auth.currentUser != null
                ? FloatingActionButton(
                    onPressed: () async {
                      // Add your onPressed code here!
                      if (widget.userRole == userRole.parents.name) {
                        appUser = AppUser.fromJson((await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser!.uid).get()).data()!);
                        studentUser = AppUser.fromJson((await FirebaseFirestore.instance.collection("users").doc(appUser!.studentRef).get()).data()!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapView(
                                    latLng: LatLng(studentUser!.currentLatitude!, studentUser!.currentLongitude!),
                                  )),
                        );
                      }
                    },
                    backgroundColor: AppColor.loginContainerColor,
                    child: Icon(Icons.navigation),
                  )
                : Container()
            : Container(),
        body: Column(
          children: [
            /// App Bar Container
            Container(
              width: width,
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      ImageRes.logo,
                      height: 55,
                      width: 150,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuScreen(userRole: widget.userRole),
                          ),
                        );
                      },
                      child: Image.asset(
                        ImageRes.menuIcon,
                        height: 14,
                        width: 31,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
            ),

            /// Body Part

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          CommonString.weAreShapingString,
                          style: CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColor.textColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: width / 3.2,
                          height: 2,
                          decoration: BoxDecoration(color: AppColor.borderColor, borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: CommonString.riseString,
                            style: CommonStyle.commonBoldTextStyle(
                                color: AppColor.blackColor, fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
                            children: <TextSpan>[
                              TextSpan(
                                text: CommonString.withAnInterString,
                                style: CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColor.textColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// CarouselSlider
                    Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 240.0,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.6,
                          autoPlay: true,
                          reverse: false,
                          enableInfiniteScroll: false,
                        ),
                        items: imgList.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                                  decoration: const BoxDecoration(color: Colors.transparent),
                                  child: Image.asset(
                                    i,
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          CommonString.areYouStrivingString,
                          style: CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColor.textColor),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: CommonString.thenString,
                            style: CommonStyle.commonBoldTextStyle(color: AppColor.blackColor, fontSize: 12, fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: CommonString.mahindraUniversityString,
                                style: CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColor.blackColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: CommonString.isString,
                            style: CommonStyle.commonBoldTextStyle(color: AppColor.blackColor, fontSize: 15, fontWeight: FontWeight.w700),
                            children: <TextSpan>[
                              TextSpan(
                                text: CommonString.forString,
                                style: CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: AppColor.blackColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: width / 3.2,
                          height: 2,
                          decoration: BoxDecoration(color: AppColor.borderColor, borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          CommonString.aUniversityText,
                          style: CommonStyle.commonRegularTextStyle(
                              height: 1.5, fontWeight: FontWeight.w700, fontSize: 12, color: AppColor.lightGreyColor),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            ImageRes.grid1,
                            height: 452,
                          ),
                          Image.asset(
                            ImageRes.grid2,
                            height: 452,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 14, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImageRes.processor,
                            height: 27,
                            width: 27,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    CommonString.worldClassString,
                                    style: CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColor.blackColor),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  CommonString.toPromoteString,
                                  style: CommonStyle.commonRegularTextStyle(
                                      fontWeight: FontWeight.w400, height: 1.3, fontSize: 14, color: AppColor.greyColor),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      ImageRes.video,
                                      height: 13,
                                      width: 13,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      CommonString.watchVideoString,
                                      style:
                                          CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: AppColor.borderColor),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 14, bottom: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImageRes.school,
                            height: 27,
                            width: 27,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    CommonString.aGreateString,
                                    style: CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColor.blackColor),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  CommonString.muString,
                                  style: CommonStyle.commonRegularTextStyle(
                                      fontWeight: FontWeight.w400, height: 1.3, fontSize: 14, color: AppColor.greyColor),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    /// Research based learning Section
                    Container(
                      width: width,
                      color: AppColor.researchContainerColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    CommonString.researchBasedString,
                                    style: CommonStyle.commonRegularTextStyle(),
                                  ),
                                ),
                                SizedBox(width: width * .004),
                                Text(
                                  CommonString.learningString,
                                  style: CommonStyle.commonBoldTextStyle(),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .015),
                            Text(
                              CommonString.itAimsString,
                              style: CommonStyle.commonRegularTextStyle(height: 1.2),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: height * .025),
                            Center(
                              child: Container(
                                width: width * .4,
                                height: height * .0055,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            SizedBox(height: height * .025),
                            Container(
                              height: height * .25,
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                  image: const DecorationImage(
                                    image: AssetImage(ImageRes.research1Image),
                                  )),
                            ),
                            SizedBox(height: height * .025),
                            Text(
                              CommonString.electricalString,
                              style: CommonStyle.commonRegularTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              CommonString.automationString,
                              style: CommonStyle.commonRegularTextStyle(height: 1.3),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: height * .025),
                            Text(
                              CommonString.learnMoreString,
                              style: CommonStyle.commonRegularUnderLineTextStyle(),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: height * .025),
                            Container(
                              height: height * .25,
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                  image: const DecorationImage(
                                    image: AssetImage(ImageRes.research2Image),
                                  )),
                            ),
                            SizedBox(height: height * .025),
                            Text(
                              CommonString.researchBasedLearningString,
                              style: CommonStyle.commonRegularTextStyle(),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              CommonString.researchBasedLearning2String,
                              style: CommonStyle.commonRegularTextStyle(height: 1.3),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: height * .025),
                            Text(
                              CommonString.learnMoreString,
                              style: CommonStyle.commonRegularUnderLineTextStyle(),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// success story Section
                    /*
                    Container(
                      // height: 700,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageRes.bottomBgImage),
                              fit: BoxFit.fill
                          ),
                          // color: Colors.redAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.asset(ImageRes.rectangleImage),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    CommonString.ourSuccessStoryString,
                                    style: CommonStyle.commonRegularTextStyle(),
                                  ),
                                  Text(
                                    CommonString.everydayString,
                                    style: CommonStyle.commonBoldTextStyle(),
                                  ),
                                  SizedBox(height: height * .015),
                                  Text(
                                    CommonString.successStoryString,
                                    style: CommonStyle.commonRegularTextStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                                    child: Container(
                                      width: width * .25,
                                      height: height * .0055,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        buildRow(CommonString.noneString,
                                            CommonString.placementsString),
                                        buildRow(CommonString.fixString,
                                            CommonString.companiesString),
                                        buildRow(CommonString.oneString,
                                            CommonString.researchPapersString),
                                        buildRow(CommonString.twoString,
                                            CommonString.awardsString),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 25),
                                    child: Center(
                                        child: Text(
                                          CommonString.weRiseString,
                                          style: CommonStyle.commonBoldTextStyle(fontSize: 40,fontWeight: FontWeight.w900),
                                        )),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 3, right: 3),
                                        child: Text(CommonString.placementsString,
                                            style: CommonStyle.commonRegularTextStyle()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 3, right: 3),
                                        child: Text(CommonString.placeString,
                                            style: CommonStyle.commonRegularTextStyle()),
                                      ),
                                      Text(CommonString.mahindraUniversityString,
                                          style:
                                          CommonStyle.commonBoldTextStyle(fontSize: 25,fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Center(
                                      child: Text(
                                        CommonString.thePlacementString,
                                        style: CommonStyle.commonRegularTextStyle(height: 1.2),
                                        textAlign: TextAlign.center,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                                    child: Center(
                                      child: Container(
                                        width: width * .25,
                                        height: height * .0055,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      buildRowLogo(
                                          ImageRes.cognizantImage, ImageRes.capgeminiImage),
                                      buildRowLogo(ImageRes.technipFMCImage,
                                          ImageRes.techMahindraImage),
                                      buildRowLogo(
                                          ImageRes.dstImage, ImageRes.sterliteTechImage),
                                      buildRowLogo(
                                          ImageRes.technipFMCImage, ImageRes.lineImage),
                                      buildRowLogo(ImageRes.ciscoImage, ImageRes.byjusImage),
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        )
                    ),
                    */
                    Image.asset(
                      ImageRes.successStory,
                      height: 712,
                      width: width,
                    ),

                    /// We are Social Section
                    Container(
                      width: width,
                      color: AppColor.blackColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                                  child: Text(
                                    CommonString.weAreString,
                                    style: CommonStyle.commonRegularTextStyle(),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3, right: 5),
                                  child: Text(
                                    CommonString.socialString,
                                    style: CommonStyle.commonBoldTextStyle(),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                buildSocial(ImageRes.fbImage),
                                buildSocial(ImageRes.tiwtterImage),
                                buildSocial(ImageRes.youTubeImage),
                                buildSocial(ImageRes.instImage),
                                buildSocial(ImageRes.LinkedinImage),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 7),
                              child: Divider(
                                color: AppColor.dividerColor,
                                thickness: 1.5,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(ImageRes.appLogoImage, width: 150),
                                const Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    CommonString.allRightsString,
                                    style: TextStyle(fontSize: 10, color: AppColor.whiteColor),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSocial(String image) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: AppColor.blackColor,
        backgroundImage: AssetImage(image),
      ),
    );
  }

  Widget buildRowLogo(String image1, String image2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.asset(image1, width: 155),
          Image.asset(image2, width: 155),
        ],
      ),
    );
  }

  Widget buildRow(String number, String des) {
    return Column(
      children: [
        Text(number, style: CommonStyle.commonBoldTextStyle(fontSize: 22)),
        Text(des, style: CommonStyle.commonRegularTextStyle(fontSize: 13)),
      ],
    );
  }
}
