import 'package:flutter/widgets.dart';

class DadosRepository extends ChangeNotifier {
  int _idUser = 0;
  int get idUser => _idUser;

  saveIdUser(int id) {
    _idUser = id;
    notifyListeners();
  }

  //LISTA
}
