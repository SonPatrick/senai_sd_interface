import 'dart:convert';

class User {
  int? status;
  String? message;
  List<Data>? data;

  User({this.status, this.message, this.data});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson);

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json['success'],
        message: json['message'],
        data: json["data"].map((x) => Data.fromJson(x)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  int? userId;
  String? userFullname;
  String? userEmail;
  String? userPass;

  Data({this.userId, this.userFullname, this.userEmail, this.userPass});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userFullname = json['user_fullname'];
    userEmail = json['user_email'];
    userPass = json['user_pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_fullname'] = userFullname;
    data['user_email'] = userEmail;
    data['user_pass'] = userPass;
    return data;
  }
}
