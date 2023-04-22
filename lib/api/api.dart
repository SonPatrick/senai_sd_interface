/**
 * Author: Patrick J. Macedo Viana
 * Date: 20/04/2023
 */
import 'dart:convert';
import 'package:senai_sd/api/api_impl.dart';
import 'package:http/http.dart' as http;
import 'package:senai_sd/models/prioridades_model.dart';
import 'package:senai_sd/models/status.dart';
import 'package:senai_sd/models/tasks_model.dart';
import 'package:senai_sd/models/tipos_model.dart';
import '../models/user_model.dart';

class Api extends ApiImpl {
  static const String url = 'http://localhost:5000/api';
  @override
  Future<User> login({required String email, required String pass}) async {
    var response = await http.post(Uri.parse('$url/login/usuario'), body: {
      'email': '${email}',
      'pass': '${pass}',
    });
    print('${response.body}');

    User model = User.fromJson(json.decode(response.body));
    return model;
  }

  @override
  Future<Tarefas> listarTarefas({required int page}) async {
    var response = await http.get(Uri.parse('$url/listar/tarefas/${page}'));
    print('${response.body}');

    Tarefas model = Tarefas.fromJson(json.decode(response.body));
    return model;
  }

  @override
  Future<Tipos> listarTipos() async {
    var response = await http.get(Uri.parse('$url/listar/tipos'));
    print('${response.body}');

    Tipos model = Tipos.fromJson(json.decode(response.body));
    return model;
  }

  @override
  Future<Status> listarStatus() async {
    var response = await http.get(Uri.parse('$url/listar/status'));
    print('${response.body}');

    Status model = Status.fromJson(json.decode(response.body));
    return model;
  }

  @override
  Future<Prioridade> listarPrioridade() async {
    var response = await http.get(Uri.parse('$url/listar/prioridades'));
    print('${response.body}');

    Prioridade model = Prioridade.fromJson(json.decode(response.body));
    return model;
  }
}
