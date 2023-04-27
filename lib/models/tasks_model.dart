class Tarefas {
  Tarefas({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final int pages;
  late final String message;
  late final List<TaskData> data;

  Tarefas.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pages = json['pages'];
    message = json['message'];
    data = List.from(json['data']).map((e) => TaskData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['pages'] = pages;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TaskData {
  TaskData({
    required this.taskUserId,
    required this.taskId,
    required this.userFullname,
    required this.taskTitle,
    required this.taskDescription,
    required this.priorityDescription,
    required this.typeDescription,
    required this.statusDescription,
    required this.createdAt,
  });
  late final int taskUserId;
  late final int taskId;
  late final String userFullname;
  late final String taskTitle;
  late final String taskDescription;
  late final String priorityDescription;
  late final String typeDescription;
  late final String statusDescription;
  late final String createdAt;

  TaskData.fromJson(Map<String, dynamic> json) {
    taskUserId = json['task_user_id'];
    taskId = json['task_id'];
    userFullname = json['user_fullname'];
    taskTitle = json['task_title'];
    taskDescription = json['task_description'];
    priorityDescription = json['priority_description'];
    typeDescription = json['type_description'];
    statusDescription = json['status_description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['task_user_id'] = taskUserId;
    _data['task_id'] = taskId;
    _data['user_fullname'] = userFullname;
    _data['task_title'] = taskTitle;
    _data['task_description'] = taskDescription;
    _data['priority_description'] = priorityDescription;
    _data['type_description'] = typeDescription;
    _data['status_description'] = statusDescription;
    _data['created_at'] = createdAt;
    return _data;
  }
}
