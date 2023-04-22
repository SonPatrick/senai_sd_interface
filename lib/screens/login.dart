// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:animate_do/animate_do.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:senai_sd/api/api.dart';
import 'package:senai_sd/models/user_model.dart';
import 'package:senai_sd/repo/dados_repo.dart';
import 'package:provider/provider.dart';
import '../utils/promo_text.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();
  GlobalKey _loginKey = GlobalKey();
  DadosRepository dados = DadosRepository();
  bool _isFill = false;
  Api api = Api();

  void _isFilled(value) => setState(() => _isFill = value);

  void _isFilledFields() {
    (_emailCtrl.text.isNotEmpty && _passCtrl.text.isNotEmpty) ? _isFilled(true) : _isFilled(false);
  }

  void _login() async {
    if (_isFill) {
      User result = await api.login(
        email: _emailCtrl.text.toString(),
        pass: _passCtrl.text.toString(),
      );

      if (result.status == 1) {
        Provider.of<DadosRepository>(context, listen: false).saveIdUser(result.data.first.userId);
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${result.message}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }
    }

    //if (_isFill) print("Login: ${_emailCtrl.text} | Pass: ${_passCtrl.text}");
  }

  @override
  void initState() {
    _emailCtrl.addListener(_isFilledFields);
    _passCtrl.addListener(_isFilledFields);

    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _margin = MediaQuery.of(context).size.width >= 700
        ? const EdgeInsets.symmetric(horizontal: 200.0)
        : const EdgeInsets.symmetric(horizontal: 0.0);
    return Scaffold(
      body: Container(
        margin: _margin,
        child: Center(
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
                        controller: _emailCtrl,
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
      ),
    );
  }
}
