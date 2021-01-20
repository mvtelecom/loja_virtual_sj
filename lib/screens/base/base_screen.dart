import 'package:flutter/material.dart';
import 'package:loja_virtual_sj/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_sj/models/page_manager.dart';
import 'package:loja_virtual_sj/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        // controlar alternancia entre as paginas
        controller: pageController,
        // não permitir a funçao de rolagem
        physics: const NeverScrollableScrollPhysics(),
        // telas do aplicativo
        children: <Widget>[
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home1'),
            ),
          ),
        ],
      ),
    );
  }
}
