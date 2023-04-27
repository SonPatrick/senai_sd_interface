class Prioridade {
  Prioridade({required this.data});
  late final List<DataPrioridade> data;

  Prioridade.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => DataPrioridade.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataPrioridade {
  DataPrioridade({
    required this.priorityId,
    required this.priorityDescription,
  });
  late final int priorityId;
  late final String priorityDescription;

  DataPrioridade.fromJson(Map<String, dynamic> json) {
    priorityId = json['priority_id'];
    priorityDescription = json['priority_description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['priority_id'] = priorityId;
    _data['priority_description'] = priorityDescription;
    return _data;
  }
}
