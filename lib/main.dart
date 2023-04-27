import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senai_sd/repo/dados_repo.dart';
import 'package:senai_sd/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DadosRepository>(create: (_) => DadosRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: CustomBehavior(),
            child: Center(child: child!),
          );
        },
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.indigo,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Login(), // Onboarding(), //
        ),
      ),
    ),
  );
}

class CustomBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => ClampingScrollPhysics();
}
