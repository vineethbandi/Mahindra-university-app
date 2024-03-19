import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mahindra_university/Utlis/colors.dart';
import 'package:permission_handler/permission_handler.dart';

String get neoBold => 'NeoBold';
String get neoRegular => 'NeoRegular';

class CommonStyle {


  static buildButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColor.btnColor),

        // padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )));
  }

  static buildButtonStyle3({Color? color}) {
    return ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColor.btnColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minimumSize: Size.fromHeight(38));

  }

  static buildButtonStyle2(Color buttonBgColor) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonBgColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )));
  }




  static commonRegularTextStyle({Color? color,double? fontSize,FontWeight? fontWeight, double? height, String? fontFamily}) {
    return TextStyle(color: color ?? AppColor.whiteColor,fontSize: fontSize ?? 12,fontWeight: fontWeight ?? FontWeight.normal,height: height ?? 1.0,fontFamily: fontFamily ?? neoRegular);
  }
  static commonBoldTextStyle({Color? color,double? fontSize,FontWeight? fontWeight,FontStyle? fontStyle, String? fontFamily}) {
    return TextStyle(color: color ?? AppColor.appbarBackground,fontFamily: fontFamily ?? neoBold,fontSize: fontSize ?? 18,fontWeight: fontWeight ?? FontWeight.normal,fontStyle: fontStyle ?? FontStyle.normal);
  }

  static commonRegularUnderLineTextStyle({Color? color,double? fontSize}) {
    return TextStyle(color: color ?? AppColor.redColor,fontFamily: neoRegular,fontSize: fontSize ?? 16,decoration: TextDecoration.underline,);
  }

  static appBarBoldTextStyle() {
    return TextStyle(color:AppColor.appbarBackground,fontFamily: neoBold,fontSize: 20);
  }

  static getLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    }
    if (status.isDenied) {
      await Permission.location.request();
      return false;
    } else {
      // openAppSettings();
      return false;
    }
  }


  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black26,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
              widthFactor: 70,
              heightFactor: 70,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Please wait...', style: TextStyle(color: Colors.white, fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

}
