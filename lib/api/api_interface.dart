import 'package:senai_sd/models/user_model.dart';

abstract class ApiInterface {
  Future<User> login({required String email, required String pass});
}
