class GeneralModel {
  GeneralModel({
    required this.status,
    required this.message,
  });
  late final int status;
  late final String message;

  GeneralModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}
