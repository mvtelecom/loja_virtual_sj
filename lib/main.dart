import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_sj/models/user_manager.dart';
import 'package:loja_virtual_sj/screens/base/base_screen.dart';
import 'package:loja_virtual_sj/screens/login/login_screen.dart';
import 'package:loja_virtual_sj/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      lazy: false,
      child: MaterialApp(
        title: 'Loja do Marcus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 124, 141),
          // cor de fundo das barras de titulo
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 124, 141),
          // cor de fundo das telas
          appBarTheme: AppBarTheme(
            // tirar a elevacao entre barra de titulo e tela
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Vai conter todas as telas do munu lateral
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
