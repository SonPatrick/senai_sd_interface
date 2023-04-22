class Tipos {
  Tipos({required this.data});
  late final List<DataTipo> data;

  Tipos.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => DataTipo.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataTipo {
  DataTipo({
    required this.typeId,
    required this.typeDescription,
  });
  late final int typeId;
  late final String typeDescription;

  DataTipo.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeDescription = json['type_description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type_id'] = typeId;
    _data['type_description'] = typeDescription;
    return _data;
  }
}
