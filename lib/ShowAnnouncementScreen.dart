import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mahindra_university/AnnouncementScreen.dart';
import 'package:mahindra_university/LoginScreen.dart';
import 'package:mahindra_university/Utlis/CommonStyle.dart';
import 'package:mahindra_university/Utlis/colors.dart';
import 'package:mahindra_university/Utlis/commonString.dart';
import 'package:mahindra_university/announcementModel.dart';
import 'package:mahindra_university/appUserModel.dart';

class ShowAnnouncement extends StatefulWidget {
  final String? userRole;
  const ShowAnnouncement({Key? key,this.userRole}) : super(key: key);

  @override
  State<ShowAnnouncement> createState() => _ShowAnnouncementState();
}

class _ShowAnnouncementState extends State<ShowAnnouncement> {
  Announcement? announcement;
  List<Announcement>? announcementList = [];
  Stream<QuerySnapshot>? _buildingsStream;
  var messageViewStream;
  Stream? userGroupStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buildingsStream = FirebaseFirestore.instance
        .collection('announcements')
        .withConverter<Announcement>(
        fromFirestore: (snapshot, _) => Announcement.fromJson(snapshot.data()!), toFirestore: (announcements, _) => announcements.toJson())
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.twoColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.borderColor,
          title: Text("Announcement",style: CommonStyle.commonBoldTextStyle(),),
        ),
        floatingActionButton: widget.userRole == userRole.faculty.name
            ? FloatingActionButton(
          onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnouncementForm()),
              );
          },
          backgroundColor: AppColor.loginContainerColor,
          child: Icon(widget.userRole == userRole.parents.name ? Icons.navigation : Icons.add),
        )
            : Container(),
        body: StreamBuilder(
          stream: _buildingsStream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            final allData = snapshot.data!.docs.map((e) => e.data()).toList();
            announcementList!.clear();
            for (int i = 0; i < allData.length; i++) {
              announcementList!.add(allData[i] as Announcement);

            }
            return announcementList!.isNotEmpty
                ? ListView.builder(
                    itemCount: announcementList!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                          color: AppColor.researchContainerColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey,width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.6),
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Image.network(
                                announcementList![index].announcementImage ??
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png",
                                height: 150,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Container(
                                  width: width,
                                    decoration: BoxDecoration(
                                    color: AppColor.borderColor,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                                    ),
                                    child: Center(
                                      child: Text(
                                        announcementList![index].announcementText!,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        // overflow: TextOverflow.ellipsis,
                                        style: CommonStyle.commonRegularTextStyle(fontSize: 14),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : Align(
              alignment: Alignment.center,
              child: Text(
                CommonString.noAnnouncementString,
                style: CommonStyle.commonRegularTextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColor.textColor),
              ),
            );
          },
        ),
      ),
    );
  }
}
