class Status {
  Status({
    required this.data,
  });
  late final List<DataStatus> data;

  Status.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => DataStatus.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataStatus {
  DataStatus({
    required this.statusId,
    required this.statusDescription,
  });
  late final int statusId;
  late final String statusDescription;

  DataStatus.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    statusDescription = json['status_description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_id'] = statusId;
    _data['status_description'] = statusDescription;
    return _data;
  }
}
