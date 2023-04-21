// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:animate_do/animate_do.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:senai_sd/api/api.dart';

import '../utils/promo_text.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _loginCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();
  GlobalKey _loginKey = GlobalKey();
  GlobalKey _registerKey = GlobalKey();
  bool _isFill = false;
  Api api = Api();

  void _isFilled(value) => setState(() => _isFill = value);

  void _isFilledFields() {
    (_loginCtrl.text.isNotEmpty && _passCtrl.text.isNotEmpty) ? _isFilled(true) : _isFilled(false);
  }

  void _login() async {
    if (_isFill) {
      var result = await api.login(
        email: _loginCtrl.text.toString(),
        pass: _passCtrl.text.toString(),
      );
      if (result.status == 1) {
        Navigator.push(
          context,
          CircularClipRoute<void>(
            builder: (context) => const Home(),
            expandFrom: _loginKey.currentContext!,
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.fastOutSlowIn,
            opacity: ConstantTween(1),
            transitionDuration: const Duration(milliseconds: 750),
          ),
        );
      } else {}
    }

    //if (_isFill) print("Login: ${_loginCtrl.text} | Pass: ${_passCtrl.text}");
  }

  @override
  void initState() {
    _loginCtrl.addListener(_isFilledFields);
    _passCtrl.addListener(_isFilledFields);

    super.initState();
  }

  @override
  void dispose() {
    _loginCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 450,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  FadeIn(
                    animate: true,
                    duration: const Duration(milliseconds: 200),
                    child: const PromoText(
                      title: "Entre",
                      subtitle: "E verifique seus chamados.",
                      color: Colors.black,
                      tSize: 25,
                      sSize: 20,
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInDown(
                    animate: true,
                    duration: const Duration(milliseconds: 350),
                    child: TextField(
                      controller: _loginCtrl,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(LineIcons.user),
                        hintText: 'Email institucional',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInDown(
                    animate: true,
                    duration: const Duration(milliseconds: 400),
                    child: TextField(
                      controller: _passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(LineIcons.lock),
                        hintText: 'Senha',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    animate: true,
                    duration: const Duration(milliseconds: 450),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: FloatingActionButton.extended(
                          key: _loginKey,
                          highlightElevation: (!_isFill) ? 0.0 : 3.0,
                          focusElevation: (!_isFill) ? 0.0 : 3.0,
                          hoverElevation: (!_isFill) ? 0.0 : 3.0,
                          elevation: (!_isFill) ? 0.0 : 3.0,
                          backgroundColor: (!_isFill) ? Colors.black54 : Colors.indigo,
                          onPressed: _login,
                          label: Text("Entrar"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
