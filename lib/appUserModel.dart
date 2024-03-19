class AppUser {
  String? userId;
  String? name;
  String? userEmail;
  String? userType;
  String? studentRef;
  double? currentLatitude;
  double? currentLongitude;

  AppUser(
      {this.userId,
        this.name,
        this.userEmail,
        this.userType,
        this.currentLatitude,
        this.currentLongitude,
        this.studentRef,
      });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
      userId: json["uid"],
      name: json['name'],
      userEmail: json['email'],
      userType: json['role'],
      currentLatitude: json['current_latitude'],
      currentLongitude: json['current_longitude'],
      studentRef: json['student_ref'],
      );

  Map<String, dynamic> toJson() => {
    "uid": userId,
    "name": name,
    "email": userEmail,
    "role": userType,
    "current_latitude": currentLatitude,
    "current_longitude": currentLongitude,
    "student_ref": studentRef,
  };
}