import 'package:senai_sd/api/api_interface.dart';
import 'package:senai_sd/models/user_model.dart';

class ApiImpl implements ApiInterface {
  @override
  Future<User> login({required String email, required String pass}) {
    throw UnimplementedError('Recurso não implementado');
  }
}
