import 'package:senai_sd/api/api_interface.dart';
import 'package:senai_sd/models/status.dart';
import 'package:senai_sd/models/prioridades_model.dart';
import 'package:senai_sd/models/tasks_model.dart';
import 'package:senai_sd/models/tipos_model.dart';
import 'package:senai_sd/models/user_model.dart';

class ApiImpl implements ApiInterface {
  @override
  Future<User> login({required String email, required String pass}) {
    throw UnimplementedError('Recurso não implementado');
  }

  @override
  Future<Tarefas> listarTarefas({required int page}) {
    throw UnimplementedError('Recurso não implementado');
  }

  @override
  Future<Prioridade> listarPrioridade() {
    throw UnimplementedError('Recurso não implementado');
  }

  @override
  Future<Status> listarStatus() async {
    throw UnimplementedError('Recurso não implementado');
  }

  @override
  Future<Tipos> listarTipos() async {
    throw UnimplementedError('Recurso não implementado');
  }
}
