class Announcement {
  String? announcementImage;
  String? announcementText;
  String? facultyRef;
  String? docId;

  Announcement({
    this.announcementImage,
    this.announcementText,
    this.facultyRef,
    this.docId,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      Announcement(
          announcementImage: (json.containsKey("announcementImage") && json["announcementImage"] != null) ? json["announcementImage"] : null,
          announcementText: json["announcementText"],
          facultyRef: json['facultyRef'],
          docId: json['docId']
      );


  Map<String, dynamic> toJson() =>
      {
        if(announcementImage != null)...{
          "announcementImage": announcementImage,
        },
        "announcementText": announcementText,
        "facultyRef": facultyRef,
        "docId": docId
      };
}