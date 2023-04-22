class User {
  User({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final String message;
  late final List<Data> data;

  User.empty();

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.userId,
    required this.userFullname,
    required this.userEmail,
    required this.userPass,
  });
  late final int userId;
  late final String userFullname;
  late final String userEmail;
  late final String userPass;

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userFullname = json['user_fullname'];
    userEmail = json['user_email'];
    userPass = json['user_pass'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['user_fullname'] = userFullname;
    _data['user_email'] = userEmail;
    _data['user_pass'] = userPass;
    return _data;
  }
}
