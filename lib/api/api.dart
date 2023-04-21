import 'dart:convert';
import 'package:senai_sd/api/api_impl.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class Api extends ApiImpl {
  static const String url = 'http://localhost:5000/api';
  @override
  Future<User> login({required String email, required String pass}) async {
    var response = await http.post(Uri.parse('$url/login'), body: {
      email: email,
      pass: pass,
    });
    print('${response.body}');
    User model = User.fromJson(json.decode(response.body));
    return model;
  }
}
