import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahindra_university/Utlis/CommonStyle.dart';
import 'package:mahindra_university/Utlis/ImageRes.dart';
import 'package:mahindra_university/Utlis/colors.dart';
import 'package:mahindra_university/announcementModel.dart';
import 'package:uuid/uuid.dart';

class AnouncementForm extends StatefulWidget {
  const AnouncementForm({Key? key}) : super(key: key);

  @override
  State<AnouncementForm> createState() => _AnouncementFormState();
}

class _AnouncementFormState extends State<AnouncementForm> {
  void setimage(ImageSource source) {
    var image = ImagePicker.platform.pickImage(source: source);
    print('iae-------------------------------------$image');
  }

  String get interBold => 'InterBold';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get interRegular => 'InterRegular';
  TextEditingController enterTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              color: const Color(0xFFFFFFFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.arrow_circle_left_outlined, size: 35)),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.asset(
                              ImageRes.logo,
                              height: 55,
                              width: 150,
                            ),
                          ),
                          Container()
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      'Announcement Image',
                      style: CommonStyle.commonRegularTextStyle(color: AppColor.blackColor.withOpacity(.6), fontFamily: neoBold, fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      if (selectedImage == null) {
                        showMediaDialog(context);
                      }
                    },
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 160,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: selectedImage != null
                            ? Image.file(
                                File(selectedImage!.path),
                                fit: BoxFit.cover,
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_circle_outline),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Add Image',
                                    style: TextStyle(color: Colors.grey, fontSize: 16, fontFamily: neoBold, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Announcement Text',
                      style: CommonStyle.commonRegularTextStyle(color: AppColor.blackColor.withOpacity(.6), fontFamily: neoBold, fontSize: 17),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 11, bottom: 11),
                    child: TextFormField(
                      controller: enterTextController,
                      maxLines: 5,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Announcement Text";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.whiteColor,
                        hintText: 'Enter Text',
                        hintStyle: CommonStyle.commonBoldTextStyle(color: Colors.grey, fontSize: 14, fontFamily: neoBold),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: ElevatedButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                              CommonStyle.showLoadingDialog(context);
                            var uuid = Uuid().v4();
                            if(selectedImage != null){
                              String url = await uploadMediaFile(File(selectedImage!.path), "image_${DateTime.now().millisecondsSinceEpoch}");
                              if (url.isNotEmpty) {

                                Announcement announcement = Announcement(
                                  announcementImage: url,
                                  announcementText: enterTextController.text,
                                  facultyRef: _auth.currentUser!.uid,
                                  docId: uuid,
                                );
                                await FirebaseFirestore.instance.collection("announcements").doc(uuid).set(announcement.toJson());
                              }
                            } else {

                              Announcement announcement = Announcement(
                                announcementText: enterTextController.text,
                                facultyRef: _auth.currentUser!.uid,
                                docId: uuid,
                              );
                              await FirebaseFirestore.instance.collection("announcements").doc(uuid).set(announcement.toJson());
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);

                          }
                        },
                        style: CommonStyle.buildButtonStyle3(),
                        child: Text(
                          'Add',
                          style: CommonStyle.commonBoldTextStyle(color: AppColor.whiteColor, fontSize: 14, fontWeight: FontWeight.w800),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  UploadTask? uploadTask;

  /// upload MediaFile to FireStore
  uploadMediaFile(File mediaFile, String filename) async {
    Reference reference = FirebaseStorage.instance.ref('announcement').child(filename);
    uploadTask = reference.putFile(mediaFile);
    // TaskSnapshot snapshot = await uploadTask;

    TaskSnapshot snapshot = await uploadTask!.whenComplete(() => null);
    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  /// Get image
  Future getImage(isFromCamera) async {
    if (isFromCamera) {
      /// camera Image
      XFile? photo = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1280, maxHeight: 720, imageQuality: 60);
      if (photo != null) {
        selectedImage = photo;
        setState(() {});
      }
    } else {
      /// gallery Image
      XFile? selectedImages = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1280, maxHeight: 720, imageQuality: 60);
      if (selectedImages != null) {
        selectedImage = selectedImages;
        setState(() {});
      }
    }
  }

  Future<String?> showMediaDialog(
    BuildContext context,
  ) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
        titlePadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        title: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.of(context).pop();
                                  getImage(true);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                        decoration: BoxDecoration(color: AppColor.appbarBackground, borderRadius: BorderRadius.circular(7)),
                                        child: Image.asset(
                                          ImageRes.cameraImage,
                                          height: 46,
                                          color: AppColor.borderColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text("Camera", style: CommonStyle.commonBoldTextStyle(color: AppColor.borderColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: AppColor.loginContainerColor.withOpacity(.2),
                            thickness: 1.5,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  getImage(false);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                        decoration: BoxDecoration(color: AppColor.appbarBackground, borderRadius: BorderRadius.circular(7)),
                                        child: Image.asset(
                                          ImageRes.galleryImage,
                                          height: 46,
                                          color: AppColor.borderColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text("Gallery", style: CommonStyle.commonBoldTextStyle(color: AppColor.borderColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
