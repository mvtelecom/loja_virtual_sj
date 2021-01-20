import 'package:loja_virtual_sj/models/user.dart';
import 'package:loja_virtual_sj/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_sj/helpers/validator.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passControler = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scafolddKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafolddKey,
      appBar: AppBar(
        title: const Text('Entrar'), //titulo da appbar
        centerTitle: true, // centralizar titulo
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: const Text('CRIAR CONTA', style: TextStyle(fontSize: 14)),
          )
        ],
      ),
      body: Center(
        // corpo fica no centro
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16), // margem da lista
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManger, child) {
                return ListView(
                  padding: const EdgeInsets.all(16), // margem do texto
                  shrinkWrap: true, // para lista ocupar a menor algura possivel
                  children: <Widget>[
                    TextFormField(
                      controller: emailControler,
                      enabled: !userManger.loading,
                      decoration: const InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email)) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passControler,
                      enabled: !userManger.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty || pass.length < 6) {
                          return 'Senha Inválida';
                        }
                        return null;
                      },
                    ),
                    child,
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44, //aluta do botao
                      child: RaisedButton(
                        onPressed: userManger.loading
                            ? null
                            : () {
                                userManger.signIn(
                                    user: User(
                                      email: emailControler.text,
                                      password: passControler.text,
                                    ),
                                    onFail: (e) {
                                      scafolddKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text('Falha ao entrar: $e'),
                                        backgroundColor: Colors.red,
                                      ));
                                    },
                                    onSucess: () {
                                      Navigator.of(context).pop();
                                    });
                              },
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManger.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18 //tamanho da fonte
                                    ),
                              ),
                      ),
                    )
                  ],
                );
              },
              child: Align(
                alignment: Alignment.centerRight, // centralizar a direita
                child: FlatButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  // tirar o espacamento final do texto
                  child: const Text('Esqueci minha Senha'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
