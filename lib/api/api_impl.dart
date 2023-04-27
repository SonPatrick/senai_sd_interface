import 'package:senai_sd/api/api_interface.dart';
import 'package:senai_sd/models/status.dart';
import 'package:senai_sd/models/prioridades_model.dart';
import 'package:senai_sd/models/tasks_model.dart';
import 'package:senai_sd/models/tipos_model.dart';
import 'package:senai_sd/models/user_model.dart';

abstract class ApiImpl implements ApiInterface {
  @override
  Future<User> login({required String email, required String pass}) {
    throw UnimplementedError('Recurso de login ainda não implementado');
  }

  @override
  Future<Tarefas> listarTarefas({required int page}) {
    throw UnimplementedError('Recurso e listar tarefas ainda não implementado');
  }

  @override
  Future<Prioridade> listarPrioridade() {
    throw UnimplementedError('Recurso e listar prioridades ainda não implementado');
  }

  @override
  Future<Status> listarStatus() async {
    throw UnimplementedError('Recurso e listar status ainda não implementado');
  }

  @override
  Future<Tipos> listarTipos() async {
    throw UnimplementedError('Recurso de listar tipos ainda não implementado');
  }

  @override
  Future<Tarefas> assumirTarefas({required int id}) {
    throw UnimplementedError('Recurso de assumir tarefas ainda não implementado');
  }
}
