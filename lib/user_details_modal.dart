import 'dart:convert';

List<UserDetailsModal> userDetailsModalFromJson(String str) => List<UserDetailsModal>.from(json.decode(str).map((x) => UserDetailsModal.fromJson(x)));

String userDetailsModalToJson(List<UserDetailsModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetailsModal {
    UserDetailsModal({
        this.userId,
        this.username,
        this.usermail,
        this.password,
        this.university,
        this.userMobile,
        this.registrationdate,
    });

    String userId;
    String username;
    String usermail;
    String password;
    String university;
    String userMobile;
    DateTime registrationdate;

    factory UserDetailsModal.fromJson(Map<String, dynamic> json) => UserDetailsModal(
        userId: json["user_id"],
        username: json["username"],
        usermail: json["usermail"],
        password: json["password"],
        university: json["university"],
        userMobile: json["user_mobile"],
        registrationdate: DateTime.parse(json["registrationdate"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "usermail": usermail,
        "password": password,
        "university": university,
        "user_mobile": userMobile,
        "registrationdate": "${registrationdate.year.toString().padLeft(4, '0')}-${registrationdate.month.toString().padLeft(2, '0')}-${registrationdate.day.toString().padLeft(2, '0')}",
    };
}