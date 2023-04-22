import 'package:senai_sd/models/prioridades_model.dart';
import 'package:senai_sd/models/status.dart';
import 'package:senai_sd/models/tasks_model.dart';
import 'package:senai_sd/models/tipos_model.dart';
import 'package:senai_sd/models/user_model.dart';

abstract class ApiInterface {
  Future<User> login({required String email, required String pass});

  Future<Tarefas> listarTarefas({required int page});

  Future<Status> listarStatus();

  Future<Prioridade> listarPrioridade();

  Future<Tipos> listarTipos();
}
